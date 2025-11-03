import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('ru')
  ];

  /// No description provided for @trackYourCycle.
  ///
  /// In en, this message translates to:
  /// **'Track your cycle'**
  String get trackYourCycle;

  /// No description provided for @lastPeriod.
  ///
  /// In en, this message translates to:
  /// **'Last Period: {date}'**
  String lastPeriod(Object date);

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data yet. Log your first cycle!'**
  String get noData;

  /// No description provided for @avatarStateResting.
  ///
  /// In en, this message translates to:
  /// **'Resting...'**
  String get avatarStateResting;

  /// No description provided for @avatarStateActive.
  ///
  /// In en, this message translates to:
  /// **'Active!'**
  String get avatarStateActive;

  /// No description provided for @calendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle Calendar'**
  String get calendarTitle;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @tapToLogPeriod.
  ///
  /// In en, this message translates to:
  /// **'Tap a day to log or unlog it'**
  String get tapToLogPeriod;

  /// No description provided for @logSymptomsButton.
  ///
  /// In en, this message translates to:
  /// **'How do you feel today?'**
  String get logSymptomsButton;

  /// No description provided for @symptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Symptoms'**
  String get symptomsTitle;

  /// No description provided for @symptomCramps.
  ///
  /// In en, this message translates to:
  /// **'Cramps'**
  String get symptomCramps;

  /// No description provided for @symptomHeadache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get symptomHeadache;

  /// No description provided for @symptomNausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get symptomNausea;

  /// No description provided for @moodHappy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get moodHappy;

  /// No description provided for @moodSad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get moodSad;

  /// No description provided for @moodIrritable.
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get moodIrritable;

  /// No description provided for @noSymptomsLogged.
  ///
  /// In en, this message translates to:
  /// **'No symptoms logged for today.'**
  String get noSymptomsLogged;

  /// No description provided for @predictionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Predictions'**
  String get predictionsTitle;

  /// No description provided for @nextPeriodPrediction.
  ///
  /// In en, this message translates to:
  /// **'Next period in ~{days} days'**
  String nextPeriodPrediction(Object days);

  /// No description provided for @nextPeriodDate.
  ///
  /// In en, this message translates to:
  /// **'Around {date}'**
  String nextPeriodDate(Object date);

  /// No description provided for @fertileWindow.
  ///
  /// In en, this message translates to:
  /// **'Fertile Window'**
  String get fertileWindow;

  /// No description provided for @ovulation.
  ///
  /// In en, this message translates to:
  /// **'Est. Ovulation'**
  String get ovulation;

  /// No description provided for @cycleLength.
  ///
  /// In en, this message translates to:
  /// **'Avg. Cycle: {days} days'**
  String cycleLength(Object days);

  /// No description provided for @periodLength.
  ///
  /// In en, this message translates to:
  /// **'Avg. Period: {days} days'**
  String periodLength(Object days);

  /// No description provided for @notEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Log at least 2 cycles to see predictions.'**
  String get notEnoughData;

  /// No description provided for @calendarLegendPeriod.
  ///
  /// In en, this message translates to:
  /// **'Your Period'**
  String get calendarLegendPeriod;

  /// No description provided for @calendarLegendPredicted.
  ///
  /// In en, this message translates to:
  /// **'Predicted Period'**
  String get calendarLegendPredicted;

  /// No description provided for @calendarLegendFertile.
  ///
  /// In en, this message translates to:
  /// **'Fertile Window'**
  String get calendarLegendFertile;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Bloom!'**
  String get welcomeTitle;

  /// No description provided for @welcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Your personal cycle pal. Let\'s get you set up.'**
  String get welcomeDesc;

  /// No description provided for @questionPeriodTitle.
  ///
  /// In en, this message translates to:
  /// **'When did your last period start?'**
  String get questionPeriodTitle;

  /// No description provided for @questionPeriodDesc.
  ///
  /// In en, this message translates to:
  /// **'You can log this in the calendar. If you don\'t remember, that\'s okay!'**
  String get questionPeriodDesc;

  /// No description provided for @questionLengthTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your average cycle length?'**
  String get questionLengthTitle;

  /// No description provided for @questionLengthDesc.
  ///
  /// In en, this message translates to:
  /// **'This is the time from one period start to the next. (Default is 28 days)'**
  String get questionLengthDesc;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @pickADate.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get pickADate;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Show alerts for predictions'**
  String get settingsNotificationsDesc;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupport;

  /// No description provided for @settingsSupportDesc.
  ///
  /// In en, this message translates to:
  /// **'Report a bug or ask a question'**
  String get settingsSupportDesc;

  /// No description provided for @notificationPeriodTitle.
  ///
  /// In en, this message translates to:
  /// **'Heads up from Bloom!'**
  String get notificationPeriodTitle;

  /// No description provided for @notificationPeriodBody.
  ///
  /// In en, this message translates to:
  /// **'Your period is predicted to start in {days} days.'**
  String notificationPeriodBody(Object days);

  /// No description provided for @notificationFertileTitle.
  ///
  /// In en, this message translates to:
  /// **'Heads up from Bloom!'**
  String get notificationFertileTitle;

  /// No description provided for @notificationFertileBody.
  ///
  /// In en, this message translates to:
  /// **'Your fertile window is predicted to start tomorrow.'**
  String get notificationFertileBody;

  /// No description provided for @logPeriodStartButton.
  ///
  /// In en, this message translates to:
  /// **'Period Started Today'**
  String get logPeriodStartButton;

  /// No description provided for @logPeriodEndButton.
  ///
  /// In en, this message translates to:
  /// **'Period Ended Today'**
  String get logPeriodEndButton;

  /// No description provided for @periodIsActive.
  ///
  /// In en, this message translates to:
  /// **'You are on day {day} of your period'**
  String periodIsActive(Object day);

  /// No description provided for @periodDelayed.
  ///
  /// In en, this message translates to:
  /// **'Period is {days} days late'**
  String periodDelayed(Object days);

  /// No description provided for @avatarStateDelayed.
  ///
  /// In en, this message translates to:
  /// **'Waiting...'**
  String get avatarStateDelayed;

  /// No description provided for @avatarStateFollicular.
  ///
  /// In en, this message translates to:
  /// **'Energy is returning!'**
  String get avatarStateFollicular;

  /// No description provided for @avatarStateOvulation.
  ///
  /// In en, this message translates to:
  /// **'Peak energy!'**
  String get avatarStateOvulation;

  /// No description provided for @avatarStateLuteal.
  ///
  /// In en, this message translates to:
  /// **'Time to rest'**
  String get avatarStateLuteal;

  /// No description provided for @insightNone.
  ///
  /// In en, this message translates to:
  /// **'Log your first cycle in the calendar to start seeing insights!'**
  String get insightNone;

  /// No description provided for @insightMenstruation_1.
  ///
  /// In en, this message translates to:
  /// **'Time for coziness! Your energy is at its lowest - that\'s okay. Remember to rest, watch your favorite show, and maybe eat that chocolate bar. 🍫'**
  String get insightMenstruation_1;

  /// No description provided for @insightMenstruation_2.
  ///
  /// In en, this message translates to:
  /// **'Your body is doing hard work. Listen to it! Gentle stretching or a warm bath can do wonders for cramps.'**
  String get insightMenstruation_2;

  /// No description provided for @insightMenstruation_3.
  ///
  /// In en, this message translates to:
  /// **'It\'s normal to feel tired. Your hormones are at their lowest. Prioritize sleep and hydration today.'**
  String get insightMenstruation_3;

  /// No description provided for @insightFollicular_1.
  ///
  /// In en, this message translates to:
  /// **'Energy is returning! Estrogen is rising. Great day to make plans or do that workout you\'ve been putting off.'**
  String get insightFollicular_1;

  /// No description provided for @insightFollicular_2.
  ///
  /// In en, this message translates to:
  /// **'Your mind is getting clearer. This is a great time to learn something new or tackle a tricky problem.'**
  String get insightFollicular_2;

  /// No description provided for @insightFollicular_3.
  ///
  /// In en, this message translates to:
  /// **'Mood boost! As your period ends, you might feel more positive and sociable. Enjoy it!'**
  String get insightFollicular_3;

  /// No description provided for @insightOvulation_1.
  ///
  /// In en, this message translates to:
  /// **'You\'re peaking! 🌟 Today is your day to shine. Confidence and energy are at their maximum. Perfect time for challenging tasks or socializing.'**
  String get insightOvulation_1;

  /// No description provided for @insightOvulation_2.
  ///
  /// In en, this message translates to:
  /// **'You might feel extra confident today. It\'s the estrogen peak! A great day to speak up or lead a project.'**
  String get insightOvulation_2;

  /// No description provided for @insightOvulation_3.
  ///
  /// In en, this message translates to:
  /// **'Peak energy! Your body is ready for more intense exercise if you feel up for it. You might also feel more connected to others.'**
  String get insightOvulation_3;

  /// No description provided for @insightLuteal_1.
  ///
  /// In en, this message translates to:
  /// **'You might feel a bit irritable or tired - blame progesterone. This is called PMS. Be kinder to yourself, now is the time for self-care.'**
  String get insightLuteal_1;

  /// No description provided for @insightLuteal_2.
  ///
  /// In en, this message translates to:
  /// **'Food cravings? It\'s normal. Your body is burning more calories. Opt for complex carbs or dark chocolate to stay balanced.'**
  String get insightLuteal_2;

  /// No description provided for @insightLuteal_3.
  ///
  /// In en, this message translates to:
  /// **'Feeling a bit bloated or sensitive? It\'s the luteal phase. Try to reduce salt and drink extra water. It helps!'**
  String get insightLuteal_3;

  /// No description provided for @insightDelayed_1.
  ///
  /// In en, this message translates to:
  /// **'Period delayed? Small fluctuations are normal, stress or changes in routine can be the cause. Just keep track.'**
  String get insightDelayed_1;

  /// No description provided for @insightDelayed_2.
  ///
  /// In en, this message translates to:
  /// **'Waiting... It\'s common to be off by a day or two. Try to relax, get good sleep, and see what happens tomorrow.'**
  String get insightDelayed_2;

  /// No description provided for @insightDelayed_3.
  ///
  /// In en, this message translates to:
  /// **'Your body has its own rhythm. A late period can happen for many reasons. If you\'re worried, you can always talk to a trusted adult.'**
  String get insightDelayed_3;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get settingsTheme;

  /// No description provided for @themeRose.
  ///
  /// In en, this message translates to:
  /// **'Gentle Rose'**
  String get themeRose;

  /// No description provided for @themeNight.
  ///
  /// In en, this message translates to:
  /// **'Moonlit Night'**
  String get themeNight;

  /// No description provided for @themeForest.
  ///
  /// In en, this message translates to:
  /// **'Forest Calm'**
  String get themeForest;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
