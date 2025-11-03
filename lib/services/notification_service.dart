// Файл: lib/services/notification_service.dart

import 'package:bloom/models/cycle_prediction.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bloom/l10n/app_localizations.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  // Синглтон (чтобы у нас был только один экземпляр сервиса)
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  /// 1. Инициализация базы данных часовых поясов
  static Future<void> initTimezones() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('UTC')); // Установим по умолчанию
    try {
      // Пытаемся установить локальный часовой пояс
      final String localTimezone = tz.local.name;
      tz.setLocalLocation(tz.getLocation(localTimezone));
    } catch (e) {
      print('Could not set local timezone: $e');
    }
  }

  /// 2. Инициализация самого плагина (запрос разрешений)
  static Future<void> init() async {
    final service = NotificationService();

    // Настройки для Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Иконка приложения

    // Настройки для iOS
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await service._flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // Запрос разрешений (особенно важно для Android 13+)
    service._flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // Запрос разрешений (iOS)
    service._flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// 3. Планирование уведомлений
  static Future<void> schedulePredictionNotifications(
      CyclePrediction prediction, AppLocalizations l10n) async {

    final service = NotificationService();

    // Сначала отменяем ВСЕ старые, чтобы не было дублей
    await NotificationService.cancelAllNotifications();

    // Настройки для Android (канал)
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'bloom_cycle_channel',
      'Cycle Predictions',
      channelDescription: 'Notifications about cycle predictions',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails);

    // --- A. Уведомление о НАЧАЛЕ ЦИКЛА (за 2 дня) ---
    final DateTime periodScheduleTime =
    prediction.nextPeriodStartDate.subtract(const Duration(days: 2));

    // Убедимся, что дата в будущем
    if (periodScheduleTime.isAfter(DateTime.now())) {
      await service._flutterLocalNotificationsPlugin.zonedSchedule(
        0, // id = 0 (для цикла)
        l10n.notificationPeriodTitle,
        l10n.notificationPeriodBody(2), // "{days} дня"
        tz.TZDateTime.from(periodScheduleTime, tz.local), // Используем часовой пояс
        platformDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
    }

    // --- B. Уведомление о ФЕРТИЛЬНОСТИ (за 1 день) ---
    final DateTime fertileScheduleTime =
    prediction.fertileWindowStart.subtract(const Duration(days: 1));

    // Убедимся, что дата в будущем
    if (fertileScheduleTime.isAfter(DateTime.now())) {
      await service._flutterLocalNotificationsPlugin.zonedSchedule(
        1, // id = 1 (для фертильности)
        l10n.notificationFertileTitle,
        l10n.notificationFertileBody,
        tz.TZDateTime.from(fertileScheduleTime, tz.local),
        platformDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );
    }
  }

  /// 4. Отмена всех уведомлений
  static Future<void> cancelAllNotifications() async {
    await NotificationService()._flutterLocalNotificationsPlugin.cancelAll();
  }
}