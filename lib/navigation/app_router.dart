// Файл: lib/navigation/app_router.dart

import 'package:bloom/main.dart'; // Нужен для HomeScreen
import 'package:bloom/screens/onboarding_screen.dart';
import 'package:bloom/screens/settings_screen.dart';
import 'package:bloom/themes/app_themes.dart'; // Нужен для AppTheme
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  // Имена маршрутов
  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String settings = '/settings';

  static Route<dynamic> generateRoute(RouteSettings routeSettings, {
    // Функции, которые передаются из MyApp
    required bool showOnboarding,
    required Function(Locale) onLocaleChanged,
    required Function(AppTheme) onThemeChanged, // Добавлено
  }) {
    switch (routeSettings.name) {

      case home:
        return MaterialPageRoute(
          // Передаем обе функции в HomeScreen
          builder: (_) => HomeScreen(
            onLocaleChanged: onLocaleChanged,
            onThemeChanged: onThemeChanged, // Добавлено
          ),
        );

      case onboarding:
        return MaterialPageRoute(
          // OnboardingScreen тоже нужна функция смены языка
          // (хотя он не может ее вызвать, она нужна для перехода на HomeScreen)
          builder: (_) => OnboardingScreen(onLocaleChanged: onLocaleChanged),
        );

      case settings:
      // --- Извлекаем аргументы ---
      // Аргументы передаются через Navigator.pushNamed()
        final args = routeSettings.arguments as Map<String, dynamic>?;

        // Используем функции из аргументов, если они есть,
        // иначе используем функции, переданные из MyApp (как fallback)
        final langChanged = args?['onLanguageChanged'] as Function(Locale)? ?? onLocaleChanged;
        final themeChanged = args?['onThemeChanged'] as Function(AppTheme)? ?? onThemeChanged;

        return PageTransition(
          // Передаем извлеченные/fallback функции в SettingsScreen
          child: SettingsScreen(
            onLanguageChanged: langChanged,
            onThemeChanged: themeChanged,
          ),
          type: PageTransitionType.fade,
        );

      default:
      // Страница ошибки, если маршрут не найден
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Error: No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}