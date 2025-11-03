// Файл: lib/themes/app_themes.dart

import 'package:flutter/material.dart';

enum AppTheme { rose, night, forest }

class AppThemes {
  // Ключи для сохранения в SharedPreferences
  static const String roseKey = 'rose';
  static const String nightKey = 'night';
  static const String forestKey = 'forest';

  static ThemeData getThemeData(AppTheme theme) {
    switch (theme) {
      case AppTheme.night:
        return _buildThemeData(
          scaffoldColor: const Color(0xFF2C2C3E), // Темно-сине-фиолетовый
          seedColor: Colors.deepPurple[100]!, // Светло-лавандовый
          brightness: Brightness.dark, // Указываем, что тема темная
        );
      case AppTheme.forest:
        return _buildThemeData(
          scaffoldColor: const Color(0xFFF0F5F1), // Очень светло-зеленый
          seedColor: Colors.teal[100]!, // Пастельно-бирюзовый
          brightness: Brightness.light,
        );
      case AppTheme.rose:
      default:
        return _buildThemeData(
          scaffoldColor: const Color(0xFFFFFBFB), // Текущий (нежно-розовый)
          seedColor: Colors.pink[100]!, // Текущий (пастельно-розовый)
          brightness: Brightness.light,
        );
    }
  }

  static ThemeData _buildThemeData({
    required Color scaffoldColor,
    required Color seedColor,
    required Brightness brightness,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness, // Важно для цвета текста и иконок
    );

    return ThemeData(
      scaffoldBackgroundColor: scaffoldColor,
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: 'Nunito',
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        // Цвет иконок и текста AppBar подстроится под brightness
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        // Делаем карточки чуть менее прозрачными на темной теме
        color: brightness == Brightness.dark
            ? Colors.white.withOpacity(0.15)
            : Colors.white.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // Стили кнопок тоже возьмут цвета из colorScheme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            // Цвета кнопок по умолчанию будут браться из colorScheme
          )
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // Цвет текстовых кнопок
            foregroundColor: colorScheme.primary,
          )
      ),
      // ... (можно добавить стили для других виджетов)
    );
  }

  // Вспомогательные функции для конвертации Enum <-> String
  static String themeToString(AppTheme theme) {
    switch (theme) {
      case AppTheme.night: return nightKey;
      case AppTheme.forest: return forestKey;
      case AppTheme.rose: default: return roseKey;
    }
  }

  static AppTheme stringToTheme(String? themeString) {
    switch (themeString) {
      case nightKey: return AppTheme.night;
      case forestKey: return AppTheme.forest;
      case roseKey: default: return AppTheme.rose;
    }
  }
}