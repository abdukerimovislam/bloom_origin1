// Файл: lib/screens/calendar_screen.dart

import 'dart:collection';
import 'package:bloom/models/cycle_prediction.dart';
import 'package:bloom/services/cycle_service.dart';
import 'package:flutter/material.dart';
import 'package:bloom/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';

// 1. Экран больше не StatefulWidget, а StatelessWidget
class CalendarScreen extends StatefulWidget {
  final CyclePrediction? prediction;

  // 2. Нам нужна функция, чтобы "сказать" HomeScreen обновить данные
  final VoidCallback onDataChanged;

  const CalendarScreen({
    super.key,
    this.prediction,
    required this.onDataChanged,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CycleService _cycleService = CycleService();
  DateTime _focusedDay = DateTime.now();

  Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: (key) => key.day * 1000000 + key.month * 10000 + key.year,
  );

  @override
  void initState() {
    super.initState();
    _loadPeriodDays();
  }

  Future<void> _loadPeriodDays() async {
    final days = await _cycleService.getPeriodDays();
    if (mounted) {
      setState(() {
        _selectedDays = days.map((day) => DateTime.utc(day.year, day.month, day.day)).toSet();
      });
    }
  }

  // 3. --- 💡 НОВАЯ ЛОГИКА АВТО-СОХРАНЕНИЯ 💡 ---
  Future<void> _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    // (Логика из Шага 12)
    final dayUtc = DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day);
    final bool isAlreadySelected = _selectedDays.contains(dayUtc);
    final int daysToToggle = widget.prediction?.avgPeriodLength ?? 5;

    // Сначала обновляем Set в памяти
    for (int i = 0; i < daysToToggle; i++) {
      final dayInLoop = dayUtc.add(Duration(days: i));
      if (isAlreadySelected) {
        _selectedDays.remove(dayInLoop);
      } else {
        _selectedDays.add(dayInLoop);
      }
    }

    // 4. --- 💡 НЕМЕДЛЕННО СОХРАНЯЕМ В ПАМЯТЬ 💡 ---
    await _cycleService.savePeriodDays(_selectedDays.toList());

    // 5. Обновляем UI
    setState(() {
      _focusedDay = focusedDay;
    });

    // 6. "Говорим" HomeScreen, что данные изменились
    widget.onDataChanged();
  }

  // (Методы _isFertileDay и _isPredictedDay БЕЗ ИЗМЕНЕНИЙ)
  bool _isFertileDay(DateTime day) {
    final pred = widget.prediction;
    if (pred == null) return false;
    final dayUtc = DateTime.utc(day.year, day.month, day.day);
    return !dayUtc.isBefore(pred.fertileWindowStart) &&
        !dayUtc.isAfter(pred.fertileWindowEnd);
  }
  bool _isPredictedDay(DateTime day) {
    final pred = widget.prediction;
    if (pred == null) return false;
    final dayUtc = DateTime.utc(day.year, day.month, day.day);
    for (int i = 0; i < pred.avgPeriodLength; i++) {
      final predictedDate = pred.nextPeriodStartDate.add(Duration(days: i));
      if (isSameDay(dayUtc, predictedDate)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // 7. --- 💡 УБРАЛИ SCAFFOLD И APPBAR 💡 ---
    return SingleChildScrollView(
      child: Column(
        children: [
          // 8. Добавили отступ, т.к. AppBar'а больше нет
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              l10n.tapToLogPeriod,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          TableCalendar(
            locale: l10n.localeName,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return _selectedDays.contains(day);
            },
            onDaySelected: _onDaySelected, // Наша новая "умная" функция

            // (calendarBuilders, headerStyle БЕЗ ИЗМЕНЕНИЙ)
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (_selectedDays.contains(day)) {
                  return _buildDayMarker(day.day.toString(), Colors.pink[300]!);
                }
                if (_isFertileDay(day)) {
                  return _buildDayMarker(
                      day.day.toString(), Colors.blue[100]!, withBorder: true
                  );
                }
                if (_isPredictedDay(day)) {
                  return _buildDayMarker(
                      day.day.toString(), Colors.pink[100]!, withBorder: true
                  );
                }
                return null;
              },
              todayBuilder: (context, day, focusedDay) {
                return _buildDayMarker(
                    day.day.toString(), Colors.purple[100]!, withTextBorder: true
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return _buildDayMarker(day.day.toString(), Colors.pink[300]!);
              },
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 20),
          _buildLegend(l10n),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // (Виджеты _buildDayMarker и _LegendItem БЕЗ ИЗМЕНЕНИЙ)
  Widget _buildDayMarker(String text, Color color, {bool withBorder = false, bool withTextBorder = false}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: withBorder ? Colors.transparent : color,
        border: withBorder ? Border.all(color: color, width: 2) : null,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: withTextBorder ? Colors.purple[900] : null,
              fontWeight: withTextBorder ? FontWeight.bold : FontWeight.normal
          ),
        ),
      ),
    );
  }
  Widget _buildLegend(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 16.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.center,
        children: [
          _LegendItem(color: Colors.pink[300]!, text: l10n.calendarLegendPeriod),
          _LegendItem(color: Colors.pink[100]!, text: l10n.calendarLegendPredicted, hasBorder: true),
          _LegendItem(color: Colors.blue[100]!, text: l10n.calendarLegendFertile, hasBorder: true),
        ],
      ),
    );
  }
}
class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final bool hasBorder;
  const _LegendItem({required this.color, required this.text, this.hasBorder = false});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: hasBorder ? Colors.transparent : color,
            border: hasBorder ? Border.all(color: color, width: 2) : null,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}