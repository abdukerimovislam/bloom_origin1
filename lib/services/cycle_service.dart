// Файл: lib/services/cycle_service.dart

import 'dart:math';
import 'package:bloom/models/cycle_prediction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CycleService {
  static const String _keyPeriodDays = 'periodDays';
  static const String _keyAvgCycleLengthManual = 'avgCycleLengthManual';
  static const String _keyOnboardingComplete = 'onboardingComplete';

  // --- НОВЫЕ КЛЮЧИ ---
  static const String _keyIsPeriodActive = 'isPeriodActive';
  static const String _keyActivePeriodStart = 'activePeriodStart';
  // ---

  Future<void> savePeriodDays(List<DateTime> dates) async {
    final prefs = await SharedPreferences.getInstance();
    final dateStrings = dates.map((date) => date.toString()).toList();
    await prefs.setStringList(_keyPeriodDays, dateStrings);
  }

  Future<List<DateTime>> getPeriodDays() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStrings = prefs.getStringList(_keyPeriodDays);
    if (dateStrings == null) return [];
    final dates = dateStrings
        .map((dateString) => DateTime.tryParse(dateString))
        .where((date) => date != null)
        .cast<DateTime>()
        .toList();
    return dates;
  }

  // --- НОВЫЕ МЕТОДЫ ДЛЯ "АКТИВНОГО" ЦИКЛА ---

  Future<bool> isPeriodActive() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsPeriodActive) ?? false;
  }

  Future<DateTime?> getActivePeriodStart() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString(_keyActivePeriodStart);
    if (dateString == null) return null;
    return DateTime.tryParse(dateString);
  }

  Future<void> startPeriod(DateTime startDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsPeriodActive, true);
    await prefs.setString(_keyActivePeriodStart, startDate.toIso8601String());
  }

  Future<void> endPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsPeriodActive, false);
    await prefs.remove(_keyActivePeriodStart);
  }

  // --- (Остальные методы без изменений) ---

  Future<void> saveManualAvgCycleLength(int length) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyAvgCycleLengthManual, length);
  }

  Future<int> getManualAvgCycleLength() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyAvgCycleLengthManual) ?? 28;
  }

  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboardingComplete) ?? false;
  }

  Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboardingComplete, true);
  }


  Future<CyclePrediction?> getCyclePredictions() async {
    final periodDays = await getPeriodDays();
    if (periodDays.isEmpty) return null;

    final periodGroups = _groupDays(periodDays, 2);
    if (periodGroups.isEmpty) return null;

    final totalPeriodDays = periodGroups.fold<int>(0, (sum, group) => sum + group.length);
    final avgPeriodLength = (totalPeriodDays / periodGroups.length).round();
    final startDates = periodGroups.map((group) => group.first).toList();

    int avgCycleLength;

    if (startDates.length < 2) {
      avgCycleLength = await getManualAvgCycleLength();
    } else {
      final List<int> cycleLengths = [];
      for (int i = 0; i < startDates.length - 1; i++) {
        final length = startDates[i + 1].difference(startDates[i]).inDays;
        cycleLengths.add(length);
      }

      if (cycleLengths.length >= 4) {
        cycleLengths.sort();
        final stableLengths = cycleLengths.sublist(1, cycleLengths.length - 1);
        avgCycleLength = (stableLengths.reduce((a, b) => a + b) / stableLengths.length).round();
      } else {
        avgCycleLength = cycleLengths.isEmpty
            ? await getManualAvgCycleLength()
            : (cycleLengths.reduce((a, b) => a + b) / cycleLengths.length).round();
      }
    }

    final lastPeriodStartDate = startDates.last;
    final nextPeriodStartDate = lastPeriodStartDate.add(Duration(days: avgCycleLength));
    final nextOvulationDate = nextPeriodStartDate.subtract(const Duration(days: 14));
    final fertileWindowStart = nextOvulationDate.subtract(const Duration(days: 5));
    final fertileWindowEnd = nextOvulationDate;

    return CyclePrediction(
      avgCycleLength: avgCycleLength,
      avgPeriodLength: max(1, avgPeriodLength),
      nextPeriodStartDate: nextPeriodStartDate,
      nextOvulationDate: nextOvulationDate,
      fertileWindowStart: fertileWindowStart,
      fertileWindowEnd: fertileWindowEnd,
    );
  }

  List<List<DateTime>> _groupDays(List<DateTime> days, int maxGap) {
    if (days.isEmpty) return [];
    days.sort((a, b) => a.compareTo(b));
    List<List<DateTime>> groups = [];
    List<DateTime> currentGroup = [days.first];
    for (int i = 1; i < days.length; i++) {
      final prevDay = days[i - 1];
      final currentDay = days[i];
      if (currentDay.difference(prevDay).inDays <= maxGap) {
        currentGroup.add(currentDay);
      } else {
        groups.add(currentGroup);
        currentGroup = [currentDay];
      }
    }
    groups.add(currentGroup);
    return groups;
  }
}