// Файл: lib/services/settings_service.dart

import 'package:bloom/themes/app_themes.dart'; // Наш новый файл
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _keyNotificationsEnabled = 'notificationsEnabled';
  static const String _keyAppLocale = 'appLocale';
  // --- НОВЫЙ КЛЮЧ ---
  static const String _keyAppTheme = 'appTheme';

  // --- Уведомления ---
  Future<void> setNotificationsEnabled(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotificationsEnabled, isEnabled);
  }
  Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotificationsEnabled) ?? true;
  }

  // --- Язык ---
  Future<void> setAppLocale(String localeCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAppLocale, localeCode);
  }
  Future<String?> getAppLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyAppLocale);
  }

  // --- 💡 НОВЫЕ МЕТОДЫ ДЛЯ ТЕМЫ 💡 ---
  Future<void> setAppTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAppTheme, AppThemes.themeToString(theme));
  }
  Future<AppTheme> getAppTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_keyAppTheme);
    return AppThemes.stringToTheme(themeString); // По умолчанию вернет 'rose'
  }
// ---
}