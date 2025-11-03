// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get trackYourCycle => 'Отслеживай свой цикл';

  @override
  String lastPeriod(Object date) {
    return 'Последний цикл: $date';
  }

  @override
  String get noData => 'Пока нет данных. Отметь свой первый цикл!';

  @override
  String get avatarStateResting => 'Отдыхаю...';

  @override
  String get avatarStateActive => 'Активна!';

  @override
  String get calendarTitle => 'Календарь цикла';

  @override
  String get save => 'Сохранить';

  @override
  String get tapToLogPeriod => 'Нажми на день, чтобы отметить/снять отметку';

  @override
  String get logSymptomsButton => 'Как ты себя чувствуешь?';

  @override
  String get symptomsTitle => 'Симптомы сегодня';

  @override
  String get symptomCramps => 'Спазмы';

  @override
  String get symptomHeadache => 'Головная боль';

  @override
  String get symptomNausea => 'Тошнота';

  @override
  String get moodHappy => 'Радость';

  @override
  String get moodSad => 'Грусть';

  @override
  String get moodIrritable => 'Раздражение';

  @override
  String get noSymptomsLogged => 'Симптомы не отмечены.';

  @override
  String get predictionsTitle => 'Прогнозы';

  @override
  String nextPeriodPrediction(Object days) {
    return 'Следующий цикл ~ через $days д.';
  }

  @override
  String nextPeriodDate(Object date) {
    return 'Примерно $date';
  }

  @override
  String get fertileWindow => 'Фертильное окно';

  @override
  String get ovulation => 'Овуляция';

  @override
  String cycleLength(Object days) {
    return 'Средний цикл: $days д.';
  }

  @override
  String periodLength(Object days) {
    return 'Средняя длит.: $days д.';
  }

  @override
  String get notEnoughData => 'Нужно 2+ цикла для прогноза.';

  @override
  String get calendarLegendPeriod => 'Ваш цикл';

  @override
  String get calendarLegendPredicted => 'Прогноз цикла';

  @override
  String get calendarLegendFertile => 'Фертильное окно';

  @override
  String get welcomeTitle => 'Добро пожаловать в Bloom!';

  @override
  String get welcomeDesc =>
      'Твой личный друг для цикла. Давай настроим приложение.';

  @override
  String get questionPeriodTitle => 'Когда начался твой последний цикл?';

  @override
  String get questionPeriodDesc =>
      'Ты можешь отметить это в календаре. Если не помнишь — не страшно!';

  @override
  String get questionLengthTitle => 'Какая у тебя средняя длина цикла?';

  @override
  String get questionLengthDesc =>
      'Это время от начала одного цикла до начала следующего. (По умолчанию 28 дней)';

  @override
  String get skip => 'Пропустить';

  @override
  String get done => 'Готово';

  @override
  String get pickADate => 'Выбрать дату';

  @override
  String get days => 'дней';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsNotifications => 'Уведомления';

  @override
  String get settingsNotificationsDesc => 'Показывать оповещения о прогнозах';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsSupport => 'Поддержка';

  @override
  String get settingsSupportDesc => 'Сообщить об ошибке или задать вопрос';

  @override
  String get notificationPeriodTitle => 'Bloom напоминает!';

  @override
  String notificationPeriodBody(Object days) {
    return 'Твой цикл, возможно, начнется через $days дня.';
  }

  @override
  String get notificationFertileTitle => 'Bloom напоминает!';

  @override
  String get notificationFertileBody =>
      'Твое фертильное окно, возможно, начнется завтра.';

  @override
  String get logPeriodStartButton => 'Цикл начался сегодня';

  @override
  String get logPeriodEndButton => 'Цикл закончился сегодня';

  @override
  String periodIsActive(Object day) {
    return 'У тебя $day день цикла';
  }

  @override
  String periodDelayed(Object days) {
    return 'Задержка $days д.';
  }

  @override
  String get avatarStateDelayed => 'Ожидание...';

  @override
  String get avatarStateFollicular => 'Энергия возвращается!';

  @override
  String get avatarStateOvulation => 'Пик энергии!';

  @override
  String get avatarStateLuteal => 'Время отдохнуть';

  @override
  String get insightNone =>
      'Отметь свой первый цикл в календаре, чтобы видеть советы!';

  @override
  String get insightMenstruation_1 =>
      'Время для уюта! Твоя энергия на минимуме — это нормально. Не забудь отдохнуть, посмотреть любимый сериал и, может быть, съесть ту самую шоколадку. 🍫';

  @override
  String get insightMenstruation_2 =>
      'Твое тело усердно работает. Прислушайся к нему! Легкая растяжка или теплая ванна могут творить чудеса.';

  @override
  String get insightMenstruation_3 =>
      'Чувствовать усталость — это нормально. Твои гормоны на самом низком уровне. Сон и вода — твои лучшие друзья сегодня.';

  @override
  String get insightFollicular_1 =>
      'Энергия возвращается! Эстроген на подъеме. Отличный день, чтобы составить планы или заняться спортом, который ты откладывала.';

  @override
  String get insightFollicular_2 =>
      'Твой ум проясняется. Это отличное время, чтобы выучить что-то новое или решить сложную задачу.';

  @override
  String get insightFollicular_3 =>
      'Настроение вверх! Цикл заканчивается, и ты можешь чувствовать себя более позитивно и общительно. Наслаждайся!';

  @override
  String get insightOvulation_1 =>
      'Ты на пике! 🌟 Сегодня твой день, чтобы блистать. Уверенность и энергия на максимуме. Идеальное время для сложных задач или общения.';

  @override
  String get insightOvulation_2 =>
      'Ты можешь чувствовать себя особенно уверенно. Это пик эстрогена! Отличный день, чтобы высказать свое мнение или возглавить проект.';

  @override
  String get insightOvulation_3 =>
      'Пик энергии! Твое тело готово к более интенсивным тренировкам, если ты в настроении. Ты также можешь чувствовать особую связь с другими.';

  @override
  String get insightLuteal_1 =>
      'Ты можешь чувствовать себя немного раздражительной или уставшей — это виноват прогестерон. Это называется ПМС. Будь нежнее к себе, сейчас время для заботы.';

  @override
  String get insightLuteal_2 =>
      'Тянет на еду? Это нормально. Твое тело сжигает больше калорий. Выбирай сложные углеводы или темный шоколад, чтобы сохранить баланс.';

  @override
  String get insightLuteal_3 =>
      'Чувствуешь вздутие или чувствительность? Это лютеиновая фаза. Попробуй уменьшить количество соли и пить больше воды. Это помогает!';

  @override
  String get insightDelayed_1 =>
      'Задержка? Небольшие сбои — это нормально, причиной может быть стресс или изменение ритма жизни. Просто держи в курсе.';

  @override
  String get insightDelayed_2 =>
      'Ожидание... Опоздание на пару дней — это обычное дело. Постарайся расслабиться, хорошо выспаться и посмотреть, что будет завтра.';

  @override
  String get insightDelayed_3 =>
      'У твоего тела свой ритм. Задержка может случиться по многим причинам. Если ты беспокоишься, ты всегда можешь поговорить со взрослым, которому доверяешь.';

  @override
  String get settingsTheme => 'Тема приложения';

  @override
  String get themeRose => 'Нежная Роза';

  @override
  String get themeNight => 'Лунная Ночь';

  @override
  String get themeForest => 'Лесное Спокойствие';
}
