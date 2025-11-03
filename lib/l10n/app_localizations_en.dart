// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get trackYourCycle => 'Track your cycle';

  @override
  String lastPeriod(Object date) {
    return 'Last Period: $date';
  }

  @override
  String get noData => 'No data yet. Log your first cycle!';

  @override
  String get avatarStateResting => 'Resting...';

  @override
  String get avatarStateActive => 'Active!';

  @override
  String get calendarTitle => 'Cycle Calendar';

  @override
  String get save => 'Save';

  @override
  String get tapToLogPeriod => 'Tap a day to log or unlog it';

  @override
  String get logSymptomsButton => 'How do you feel today?';

  @override
  String get symptomsTitle => 'Today\'s Symptoms';

  @override
  String get symptomCramps => 'Cramps';

  @override
  String get symptomHeadache => 'Headache';

  @override
  String get symptomNausea => 'Nausea';

  @override
  String get moodHappy => 'Happy';

  @override
  String get moodSad => 'Sad';

  @override
  String get moodIrritable => 'Irritable';

  @override
  String get noSymptomsLogged => 'No symptoms logged for today.';

  @override
  String get predictionsTitle => 'Predictions';

  @override
  String nextPeriodPrediction(Object days) {
    return 'Next period in ~$days days';
  }

  @override
  String nextPeriodDate(Object date) {
    return 'Around $date';
  }

  @override
  String get fertileWindow => 'Fertile Window';

  @override
  String get ovulation => 'Est. Ovulation';

  @override
  String cycleLength(Object days) {
    return 'Avg. Cycle: $days days';
  }

  @override
  String periodLength(Object days) {
    return 'Avg. Period: $days days';
  }

  @override
  String get notEnoughData => 'Log at least 2 cycles to see predictions.';

  @override
  String get calendarLegendPeriod => 'Your Period';

  @override
  String get calendarLegendPredicted => 'Predicted Period';

  @override
  String get calendarLegendFertile => 'Fertile Window';

  @override
  String get welcomeTitle => 'Welcome to Bloom!';

  @override
  String get welcomeDesc => 'Your personal cycle pal. Let\'s get you set up.';

  @override
  String get questionPeriodTitle => 'When did your last period start?';

  @override
  String get questionPeriodDesc =>
      'You can log this in the calendar. If you don\'t remember, that\'s okay!';

  @override
  String get questionLengthTitle => 'What\'s your average cycle length?';

  @override
  String get questionLengthDesc =>
      'This is the time from one period start to the next. (Default is 28 days)';

  @override
  String get skip => 'Skip';

  @override
  String get done => 'Done';

  @override
  String get pickADate => 'Pick a date';

  @override
  String get days => 'days';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsNotificationsDesc => 'Show alerts for predictions';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsSupportDesc => 'Report a bug or ask a question';

  @override
  String get notificationPeriodTitle => 'Heads up from Bloom!';

  @override
  String notificationPeriodBody(Object days) {
    return 'Your period is predicted to start in $days days.';
  }

  @override
  String get notificationFertileTitle => 'Heads up from Bloom!';

  @override
  String get notificationFertileBody =>
      'Your fertile window is predicted to start tomorrow.';

  @override
  String get logPeriodStartButton => 'Period Started Today';

  @override
  String get logPeriodEndButton => 'Period Ended Today';

  @override
  String periodIsActive(Object day) {
    return 'You are on day $day of your period';
  }

  @override
  String periodDelayed(Object days) {
    return 'Period is $days days late';
  }

  @override
  String get avatarStateDelayed => 'Waiting...';

  @override
  String get avatarStateFollicular => 'Energy is returning!';

  @override
  String get avatarStateOvulation => 'Peak energy!';

  @override
  String get avatarStateLuteal => 'Time to rest';

  @override
  String get insightNone =>
      'Log your first cycle in the calendar to start seeing insights!';

  @override
  String get insightMenstruation_1 =>
      'Time for coziness! Your energy is at its lowest - that\'s okay. Remember to rest, watch your favorite show, and maybe eat that chocolate bar. 🍫';

  @override
  String get insightMenstruation_2 =>
      'Your body is doing hard work. Listen to it! Gentle stretching or a warm bath can do wonders for cramps.';

  @override
  String get insightMenstruation_3 =>
      'It\'s normal to feel tired. Your hormones are at their lowest. Prioritize sleep and hydration today.';

  @override
  String get insightFollicular_1 =>
      'Energy is returning! Estrogen is rising. Great day to make plans or do that workout you\'ve been putting off.';

  @override
  String get insightFollicular_2 =>
      'Your mind is getting clearer. This is a great time to learn something new or tackle a tricky problem.';

  @override
  String get insightFollicular_3 =>
      'Mood boost! As your period ends, you might feel more positive and sociable. Enjoy it!';

  @override
  String get insightOvulation_1 =>
      'You\'re peaking! 🌟 Today is your day to shine. Confidence and energy are at their maximum. Perfect time for challenging tasks or socializing.';

  @override
  String get insightOvulation_2 =>
      'You might feel extra confident today. It\'s the estrogen peak! A great day to speak up or lead a project.';

  @override
  String get insightOvulation_3 =>
      'Peak energy! Your body is ready for more intense exercise if you feel up for it. You might also feel more connected to others.';

  @override
  String get insightLuteal_1 =>
      'You might feel a bit irritable or tired - blame progesterone. This is called PMS. Be kinder to yourself, now is the time for self-care.';

  @override
  String get insightLuteal_2 =>
      'Food cravings? It\'s normal. Your body is burning more calories. Opt for complex carbs or dark chocolate to stay balanced.';

  @override
  String get insightLuteal_3 =>
      'Feeling a bit bloated or sensitive? It\'s the luteal phase. Try to reduce salt and drink extra water. It helps!';

  @override
  String get insightDelayed_1 =>
      'Period delayed? Small fluctuations are normal, stress or changes in routine can be the cause. Just keep track.';

  @override
  String get insightDelayed_2 =>
      'Waiting... It\'s common to be off by a day or two. Try to relax, get good sleep, and see what happens tomorrow.';

  @override
  String get insightDelayed_3 =>
      'Your body has its own rhythm. A late period can happen for many reasons. If you\'re worried, you can always talk to a trusted adult.';

  @override
  String get settingsTheme => 'App Theme';

  @override
  String get themeRose => 'Gentle Rose';

  @override
  String get themeNight => 'Moonlit Night';

  @override
  String get themeForest => 'Forest Calm';
}
