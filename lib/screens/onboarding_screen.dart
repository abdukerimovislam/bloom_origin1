// Файл: lib/screens/onboarding_screen.dart

import 'package:bloom/main.dart';
import 'package:bloom/services/cycle_service.dart';
import 'package:flutter/material.dart';
import 'package:bloom/l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:numberpicker/numberpicker.dart';

import '../navigation/app_router.dart';

class OnboardingScreen extends StatefulWidget {
  final Function(Locale) onLocaleChanged;

  const OnboardingScreen({
    super.key,
    required this.onLocaleChanged,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CycleService _cycleService = CycleService();

  int _avgCycleLength = 28;
  DateTime? _lastPeriodStart;

  void _onDone() async {
    await _cycleService.saveManualAvgCycleLength(_avgCycleLength);

    if (_lastPeriodStart != null) {
      await _cycleService.savePeriodDays([_lastPeriodStart!]);
    }

    await _cycleService.setOnboardingComplete();

    if (mounted) {
      // 2. ИСПОЛЬЗУЕМ ПЕРЕХОД ПО ИМЕНИ
      Navigator.of(context).pushReplacementNamed(AppRouter.home);
    }
  }

  Future<void> _pickLastPeriodDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 90)),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        _lastPeriodStart = date;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // ... (весь остальной код build() остается БЕЗ ИЗМЕНЕНИЙ) ...
    final l10n = AppLocalizations.of(context)!;

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black87),
      bodyTextStyle: TextStyle(fontSize: 19.0, color: Colors.black54),
      bodyPadding: EdgeInsets.all(16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: l10n.welcomeTitle,
          body: l10n.welcomeDesc,
          image: const Center(
            child: Icon(Icons.auto_stories_rounded, size: 100, color: Colors.pinkAccent),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: l10n.questionPeriodTitle,
          body: l10n.questionPeriodDesc,
          footer: ElevatedButton(
            onPressed: () => _pickLastPeriodDate(context),
            child: Text(
                _lastPeriodStart == null
                    ? l10n.pickADate
                    : "${_lastPeriodStart!.day}.${_lastPeriodStart!.month}.${_lastPeriodStart!.year}"
            ),
          ),
          image: const Center(
            child: Icon(Icons.calendar_month_outlined, size: 100, color: Colors.pinkAccent),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: l10n.questionLengthTitle,
          body: l10n.questionLengthDesc,
          footer: NumberPicker(
            value: _avgCycleLength,
            minValue: 15,
            maxValue: 45,
            step: 1,
            axis: Axis.horizontal,
            onChanged: (value) {
              setState(() {
                _avgCycleLength = value;
              });
            },
          ),
          image: const Center(
            child: Icon(Icons.sync_rounded, size: 100, color: Colors.pinkAccent),
          ),
          decoration: pageDecoration,
        ),
      ],

      onDone: _onDone,
      onSkip: _onDone,
      showSkipButton: true,
      skip: Text(l10n.skip, style: const TextStyle(fontWeight: FontWeight.bold)),
      next: const Icon(Icons.arrow_forward),
      done: Text(l10n.done, style: const TextStyle(fontWeight: FontWeight.bold)),

      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        color: Colors.grey,
        activeColor: Colors.pinkAccent,
        activeSize: const Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}