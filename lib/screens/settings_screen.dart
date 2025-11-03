// Файл: lib/screens/settings_screen.dart

import 'package:bloom/services/settings_service.dart';
import 'package:bloom/themes/app_themes.dart'; // Наш новый файл
import 'package:flutter/material.dart';
import 'package:bloom/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  final Function(Locale) onLanguageChanged;
  // --- 💡 НОВАЯ ФУНКЦИЯ ДЛЯ СМЕНЫ ТЕМЫ 💡 ---
  final Function(AppTheme) onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.onLanguageChanged,
    required this.onThemeChanged, // НОВОЕ
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService();
  bool _notificationsEnabled = true;
  String? _currentLocaleCode;
  // --- 💡 ТЕКУЩАЯ ТЕМА 💡 ---
  AppTheme _currentTheme = AppTheme.rose;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    final notifs = await _settingsService.areNotificationsEnabled();
    final localeCode = await _settingsService.getAppLocale();
    // --- Загружаем тему ---
    final theme = await _settingsService.getAppTheme();
    if (mounted) {
      setState(() {
        _notificationsEnabled = notifs;
        _currentLocaleCode = localeCode;
        _currentTheme = theme; // НОВОЕ
      });
    }
  }

  void _onNotificationChanged(bool value) {
    setState(() { _notificationsEnabled = value; });
    _settingsService.setNotificationsEnabled(value);
  }

  void _onLanguageChanged(String? newLocaleCode) {
    if (newLocaleCode == null) return;
    setState(() { _currentLocaleCode = newLocaleCode; });
    _settingsService.setAppLocale(newLocaleCode);
    widget.onLanguageChanged(Locale(newLocaleCode));
  }

  // --- 💡 ФУНКЦИЯ СМЕНЫ ТЕМЫ 💡 ---
  void _onThemeSelected(AppTheme? newTheme) {
    if (newTheme == null) return;
    setState(() { _currentTheme = newTheme; });
    // Сохраняем и передаем в MyApp
    _settingsService.setAppTheme(newTheme);
    widget.onThemeChanged(newTheme);
  }

  void _launchSupportEmail() async {
    // ... (этот метод без изменений)
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@bloom.app',
      query: 'subject=Bloom App Support',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open email app.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final String displayLocale = _currentLocaleCode ?? l10n.localeName;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        children: [
          // --- Уведомления ---
          SwitchListTile(
            title: Text(l10n.settingsNotifications),
            subtitle: Text(l10n.settingsNotificationsDesc),
            value: _notificationsEnabled,
            onChanged: _onNotificationChanged,
            secondary: const Icon(Icons.notifications_active_outlined),
          ),
          const Divider(),

          // --- Язык ---
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(l10n.settingsLanguage),
            trailing: DropdownButton<String>(
              value: displayLocale,
              onChanged: _onLanguageChanged,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ru', child: Text('Русский')),
                DropdownMenuItem(value: 'es', child: Text('Español')),
              ],
            ),
          ),
          const Divider(),

          // --- 💡 ВЫБОР ТЕМЫ 💡 ---
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(l10n.settingsTheme),
          ),
          // Используем RadioListTile для выбора
          RadioListTile<AppTheme>(
            title: Text(l10n.themeRose),
            value: AppTheme.rose,
            groupValue: _currentTheme,
            onChanged: _onThemeSelected,
          ),
          RadioListTile<AppTheme>(
            title: Text(l10n.themeNight),
            value: AppTheme.night,
            groupValue: _currentTheme,
            onChanged: _onThemeSelected,
          ),
          RadioListTile<AppTheme>(
            title: Text(l10n.themeForest),
            value: AppTheme.forest,
            groupValue: _currentTheme,
            onChanged: _onThemeSelected,
          ),
          // ---

          const Divider(),

          // --- Поддержка ---
          ListTile(
            leading: const Icon(Icons.help_outline_rounded),
            title: Text(l10n.settingsSupport),
            subtitle: Text(l10n.settingsSupportDesc),
            onTap: _launchSupportEmail,
          ),
        ],
      ),
    );
  }
}