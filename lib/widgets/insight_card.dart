// Файл: lib/widgets/insight_card.dart

import 'package:bloom/models/cycle_phase.dart';
import 'package:flutter/material.dart';
import 'package:bloom/l10n/app_localizations.dart';

class InsightCard extends StatelessWidget {
  final CyclePhase currentPhase;

  const InsightCard({super.key, required this.currentPhase});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // --- 💡 НОВАЯ ЛОГИКА ВЫБОРА СОВЕТА 💡 ---

    // 1. Создаем "карту" (Map), где ключ - это фаза,
    //    а значение - это список "функций",
    //    которые возвращают нашу локализованную строку.
    final Map<CyclePhase, List<String Function()>> insightMap = {

      CyclePhase.menstruation: [
            () => l10n.insightMenstruation_1,
            () => l10n.insightMenstruation_2,
            () => l10n.insightMenstruation_3,
      ],
      CyclePhase.follicular: [
            () => l10n.insightFollicular_1,
            () => l10n.insightFollicular_2,
            () => l10n.insightFollicular_3,
      ],
      CyclePhase.ovulation: [
            () => l10n.insightOvulation_1,
            () => l10n.insightOvulation_2,
            () => l10n.insightOvulation_3,
      ],
      CyclePhase.luteal: [
            () => l10n.insightLuteal_1,
            () => l10n.insightLuteal_2,
            () => l10n.insightLuteal_3,
      ],
      CyclePhase.delayed: [
            () => l10n.insightDelayed_1,
            () => l10n.insightDelayed_2,
            () => l10n.insightDelayed_3,
      ],
      CyclePhase.none: [
            () => l10n.insightNone,
      ],
    };

    // 2. Получаем список советов для ТЕКУЩЕЙ фазы
    final insightsForCurrentPhase = insightMap[currentPhase] ?? [() => l10n.insightNone];

    // 3. Получаем "сегодняшний" день (например, 23)
    final int dayOfMonth = DateTime.now().day;

    // 4. Используем "магию" (деление с остатком),
    //    чтобы получить индекс для выбора совета.
    //    (Например, 23 % 3 = 2. Мы выберем совет №2)
    final int dailyIndex = dayOfMonth % insightsForCurrentPhase.length;

    // 5. Выбираем и "вызываем" функцию, чтобы получить текст
    final String insightText = insightsForCurrentPhase[dailyIndex]();

    // --- 💡 КОНЕЦ ЛОГИКИ 💡 ---

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          insightText,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.black87,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}