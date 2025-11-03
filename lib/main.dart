// Файл: lib.main.dart

import 'package:bloom/navigation/app_router.dart';
import 'package:bloom/models/cycle_prediction.dart';
import 'package:bloom/models/cycle_phase.dart';
import 'package:bloom/screens/calendar_screen.dart';
import 'package:bloom/screens/settings_screen.dart';
import 'package:bloom/services/cycle_service.dart';
import 'package:bloom/services/settings_service.dart';
import 'package:bloom/services/notification_service.dart';
import 'package:bloom/themes/app_themes.dart';
import 'package:bloom/widgets/cycle_avatar.dart';
import 'package:bloom/widgets/insight_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart'; // Для HapticFeedback
// import 'package:confetti/confetti.dart'; // <-- УДАЛЕНО
// import 'dart:math'; // <-- УДАЛЕНО (был нужен для confetti)
// Используем l10n напрямую из flutter_gen
import 'package:bloom/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initTimezones();
  await NotificationService.init();
  final cycleService = CycleService();
  final settingsService = SettingsService();
  final bool showOnboarding = !(await cycleService.isOnboardingComplete());
  final String? savedLocaleCode = await settingsService.getAppLocale();
  final AppTheme savedTheme = await settingsService.getAppTheme();
  runApp(MyApp(
    showOnboarding: showOnboarding,
    savedLocaleCode: savedLocaleCode,
    savedTheme: savedTheme,
  ));
}

class MyApp extends StatefulWidget {
  final bool showOnboarding;
  final String? savedLocaleCode;
  final AppTheme savedTheme;
  const MyApp({super.key, required this.showOnboarding, this.savedLocaleCode, required this.savedTheme});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  late AppTheme _currentTheme;
  @override
  void initState() {
    super.initState();
    if (widget.savedLocaleCode != null) {
      _locale = Locale(widget.savedLocaleCode!);
    }
    _currentTheme = widget.savedTheme;
  }
  void _setLocale(Locale newLocale) {
    setState(() { _locale = newLocale; });
  }
  void _setTheme(AppTheme newTheme) {
    setState(() { _currentTheme = newTheme; });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloom',
      // Используем flutter_gen localizations
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: AppThemes.getThemeData(_currentTheme),
      initialRoute: widget.showOnboarding ? AppRouter.onboarding : AppRouter.home,
      onGenerateRoute: (settings) => AppRouter.generateRoute(
        settings,
        showOnboarding: widget.showOnboarding,
        onLocaleChanged: _setLocale,
        onThemeChanged: _setTheme,
      ),
    );
  }
}

// --- HomeScreen ---
class HomeScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;
  final Function(AppTheme) onThemeChanged;
  const HomeScreen({super.key, required this.onLocaleChanged, required this.onThemeChanged});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- УДАЛЕН ConfettiController ---
  // late ConfettiController _confettiController;

  // --- ДОБАВЛЕНО Состояние для Сияния ---
  bool _showStartGlow = false;

  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  final CycleService _cycleService = CycleService();
  final SettingsService _settingsService = SettingsService();
  CyclePhase _currentPhase = CyclePhase.none;
  bool _isPeriodActive = false;
  DateTime? _activePeriodStartDate;
  int _activePeriodDayCount = 0;
  bool _isPeriodDelayed = false;
  int _daysDelayed = 0;
  List<DateTime> _periodDays = [];
  CyclePrediction? _prediction;
  bool _isLoading = true;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    // --- УДАЛЕНА инициализация confetti ---
    // _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      _loadData();
      _isDataLoaded = true;
    }
  }

  Future<void> _loadData() async {
    if (mounted && !_isLoading) { // Проверяем mounted перед setState
      setState(() { _isLoading = true; });
    } else if (!mounted && !_isLoading) {
      _isLoading = true; // Просто меняем флаг, если виджет не смонтирован
    }

    _isPeriodDelayed = false;
    _daysDelayed = 0;
    _isPeriodActive = await _cycleService.isPeriodActive();
    _activePeriodStartDate = await _cycleService.getActivePeriodStart();
    _periodDays = await _cycleService.getPeriodDays();
    _prediction = await _cycleService.getCyclePredictions();

    if (_isPeriodActive && _activePeriodStartDate != null) {
      final today = DateTime.now();
      _activePeriodDayCount = today.difference(_activePeriodStartDate!).inDays + 1;
      if (_activePeriodDayCount > 7) {
        await _endPeriod();
        return;
      }
      final bool isTodayLogged = _periodDays.any((day) => isSameDay(day, today));
      if (!isTodayLogged) {
        _periodDays.add(today);
        await _cycleService.savePeriodDays(_periodDays);
        _prediction = await _cycleService.getCyclePredictions();
      }
    }

    final today = DateTime.now();
    if (_isPeriodActive) {
      _currentPhase = CyclePhase.menstruation;
    } else if (_prediction != null) {
      final todayDate = DateTime(today.year, today.month, today.day);
      final predictedStart = _prediction!.nextPeriodStartDate;
      final predictedStartDate = DateTime(predictedStart.year, predictedStart.month, predictedStart.day);
      final ovulationDate = DateTime(_prediction!.nextOvulationDate.year, _prediction!.nextOvulationDate.month, _prediction!.nextOvulationDate.day);
      if (todayDate.isAfter(predictedStartDate)) {
        _isPeriodDelayed = true;
        _daysDelayed = todayDate.difference(predictedStartDate).inDays;
        _currentPhase = CyclePhase.delayed;
      } else if (isSameDay(todayDate, ovulationDate)) {
        _currentPhase = CyclePhase.ovulation;
      } else if (todayDate.isAfter(ovulationDate)) {
        _currentPhase = CyclePhase.luteal;
      } else {
        _currentPhase = CyclePhase.follicular;
      }
    } else {
      _currentPhase = CyclePhase.none;
    }

    if (mounted) { // Проверяем mounted перед setState
      setState(() { _isLoading = false; });
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _scheduleNotifications();
        }
      });
    } else {
      _isLoading = false; // Просто меняем флаг
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // Не можем вызвать _scheduleNotifications, так как context недоступен
        print("Widget not mounted, skipping notification scheduling in _loadData");
      });
    }
  }

  Future<void> _startPeriod() async {
    HapticFeedback.mediumImpact();
    // Запуск сияния
    if (mounted) setState(() => _showStartGlow = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _showStartGlow = false);
      }
    });

    // УДАЛЕН confetti

    if (mounted) { // Проверяем mounted перед setState
      setState(() {
        _isPeriodActive = true;
        _activePeriodStartDate = DateTime.now();
        _activePeriodDayCount = 1;
        _isPeriodDelayed = false;
        _daysDelayed = 0;
      });
    } else {
      _isPeriodActive = true;
      _activePeriodStartDate = DateTime.now();
      _activePeriodDayCount = 1;
      _isPeriodDelayed = false;
      _daysDelayed = 0;
    }
    await _cycleService.startPeriod(_activePeriodStartDate ?? DateTime.now()); // Добавил ?? DateTime.now() на всякий случай
    await _loadData();
  }

  Future<void> _endPeriod() async {
    HapticFeedback.mediumImpact();
    if (mounted) { // Проверяем mounted перед setState
      setState(() {
        _isPeriodActive = false;
        _activePeriodStartDate = null;
        _activePeriodDayCount = 0;
      });
    } else {
      _isPeriodActive = false;
      _activePeriodStartDate = null;
      _activePeriodDayCount = 0;
    }
    await _cycleService.endPeriod();
    await _loadData();
  }

  Future<void> _scheduleNotifications() async {
    if (!mounted) return; // Убедимся, что context доступен
    final bool notificationsEnabled = await _settingsService.areNotificationsEnabled();
    // Используем AppLocalizations.of(context)! только если уверены, что context есть
    final l10n = AppLocalizations.of(context)!;
    if (notificationsEnabled && _prediction != null) {
      await NotificationService.schedulePredictionNotifications(_prediction!, l10n);
    } else {
      await NotificationService.cancelAllNotifications();
    }
  }

  void _openCalendar() {
    if (!mounted) return; // Проверка перед использованием _pageController
    _pageController.animateToPage(
      1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut,
    );
  }

  void _openHome() {
    if (!mounted) return;
    _pageController.animateToPage(
      0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut,
    );
  }

  Future<void> _openSettings() async {
    if (!mounted) return; // Проверка перед использованием context
    await Navigator.of(context).pushNamed(
      AppRouter.settings,
      arguments: {
        'onLanguageChanged': widget.onLocaleChanged,
        'onThemeChanged': widget.onThemeChanged,
      },
    );
    // _loadData() вызовется в любом случае, но лучше проверить mounted
    if (mounted) await _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // --- УДАЛЕН dispose для confetti ---
    // _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Используем AppLocalizations.of(context)! здесь, т.к. build вызывается, когда context точно есть
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _currentPageIndex == 0 ? l10n.trackYourCycle : l10n.calendarTitle
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: _openSettings,
          ),
          IconButton(
            icon: Icon(
                _currentPageIndex == 0
                    ? Icons.calendar_month_outlined
                    : Icons.home_outlined
            ),
            onPressed: _currentPageIndex == 0 ? _openCalendar : _openHome,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: Lottie.asset('assets/lottie/loading_indicator.json', width: 150, height: 150,))
          : PageView( // Просто PageView, без Stack для confetti
        controller: _pageController,
        onPageChanged: (index) {
          // Используем mounted перед setState
          if (mounted) setState(() { _currentPageIndex = index; });
        },
        children: [
          _buildMainPage(context, l10n),
          CalendarScreen(
            prediction: _prediction,
            onDataChanged: () { // Заменили _loadData на анонимную функцию с проверкой
              if (mounted) _loadData();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainPage(BuildContext context, AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            CycleAvatar(
              currentPhase: _currentPhase,
            ),
            const SizedBox(height: 20),
            InsightCard(currentPhase: _currentPhase)
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
            const SizedBox(height: 20),
            _buildPeriodStatusText(context, l10n),
            _buildPredictionCard(context, l10n)
                .animate()
                .fadeIn(duration: 500.ms, delay: 200.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
            const SizedBox(height: 20),
            // Вызываем НАШ ОБНОВЛЕННЫЙ _buildPeriodButton
            _buildPeriodButton(context, l10n),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    Widget buttonContent;

    if (_isPeriodActive) {
      // Кнопка "Стоп"
      buttonContent = ElevatedButton.icon(
        icon: const Icon(Icons.stop_circle_outlined),
        label: Text(l10n.logPeriodEndButton, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          backgroundColor: Colors.grey[400],
          foregroundColor: Colors.black87,
        ),
        onPressed: _endPeriod,
      );
    } else {
      // Кнопка "Старт"
      buttonContent = ElevatedButton.icon(
        icon: const Icon(Icons.play_circle_outlined),
        label: Text(l10n.logPeriodStartButton, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        onPressed: _startPeriod,
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        if (!_isPeriodActive)
          IgnorePointer(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.5),
              ),
            )
                .animate(target: _showStartGlow ? 1 : 0)
                .scaleXY(
              begin: 0.5,
              end: 3.0, // <-- УВЕЛИЧИЛИ РАЗМЕР (было 2.0)
              duration: 800.ms, // <-- УВЕЛИЧИЛИ ДЛИТЕЛЬНОСТЬ (было 500.ms)
              curve: Curves.easeOutExpo,
            )
            // Добавим небольшую паузу перед исчезновением
                .then(delay: 100.ms) // <-- ДОБАВИЛИ ПАУЗУ
                .fadeOut(
              begin: 1.0,
              duration: 800.ms, // <-- УВЕЛИЧИЛИ ДЛИТЕЛЬНОСТЬ (было 500.ms)
              curve: Curves.easeOutExpo,
            ),
          ),
        // Сама Кнопка
        buttonContent, // Убрали анимацию появления кнопки, оставили только сияние
      ],
    );
  }

  Widget _buildPeriodStatusText(BuildContext context, AppLocalizations l10n) {
    // ... (без изменений) ...
    if (_isPeriodActive) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          l10n.periodIsActive(_activePeriodDayCount),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.error
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (_isPeriodDelayed && _daysDelayed > 0) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          l10n.periodDelayed(_daysDelayed),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.error
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
    if (_currentPhase == CyclePhase.none) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          l10n.noData,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildPredictionCard(BuildContext context, AppLocalizations l10n) {
    // ... (без изменений) ...
    if (_currentPhase != CyclePhase.follicular &&
        _currentPhase != CyclePhase.ovulation &&
        _currentPhase != CyclePhase.luteal) {
      return const SizedBox.shrink();
    }
    final prediction = _prediction;
    final DateFormat formatter = DateFormat.MMMd(l10n.localeName);
    if (prediction != null) {
      final daysUntilNextPeriod = prediction.nextPeriodStartDate.difference(DateTime.now()).inDays;
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.predictionsTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.nextPeriodPrediction(daysUntilNextPeriod > 0 ? daysUntilNextPeriod : 0),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(l10n.nextPeriodDate(formatter.format(prediction.nextPeriodStartDate))),
              const Divider(height: 24),
              Text(
                l10n.fertileWindow,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "${formatter.format(prediction.fertileWindowStart)} - ${formatter.format(prediction.fertileWindowEnd)}",
              ),
              Text(
                "${l10n.ovulation}: ${formatter.format(prediction.nextOvulationDate)}",
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.cycleLength(prediction.avgCycleLength)),
                  Text(l10n.periodLength(prediction.avgPeriodLength)),
                ],
              )
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildLastPeriodText(BuildContext context, AppLocalizations l10n) {
    // ... (без изменений) ...
    return const SizedBox.shrink();
  }
} // Конец файла