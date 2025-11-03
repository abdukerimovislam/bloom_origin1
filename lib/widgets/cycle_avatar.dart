// Файл: lib/widgets/cycle_avatar.dart

import 'package:bloom/models/cycle_phase.dart'; // НАШ НОВЫЙ ENUM
import 'package:flutter/material.dart';
import 'package:bloom/l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class CycleAvatar extends StatelessWidget {
  // 1. Принимаем ТОЛЬКО фазу
  final CyclePhase currentPhase;

  const CycleAvatar({
    super.key,
    required this.currentPhase,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String lottieAssetPath;
    String avatarText;

    switch (currentPhase) {
      case CyclePhase.menstruation:
        lottieAssetPath = 'assets/lottie/avatar_sleep.json';
        avatarText = l10n.avatarStateResting;
        break;
      case CyclePhase.follicular:
        lottieAssetPath = 'assets/lottie/avatar_follicular.json';
        avatarText = l10n.avatarStateFollicular;
        break;
      case CyclePhase.ovulation:
        lottieAssetPath = 'assets/lottie/avatar_ovulation.json';
        avatarText = l10n.avatarStateOvulation;
        break;
      case CyclePhase.luteal:
        lottieAssetPath = 'assets/lottie/avatar_luteal.json';
        avatarText = l10n.avatarStateLuteal;
        break;
      case CyclePhase.delayed:
        lottieAssetPath = 'assets/lottie/avatar_delayed.json';
        avatarText = l10n.avatarStateDelayed;
        break;
      case CyclePhase.none:
      default:
        lottieAssetPath = 'assets/lottie/avatar_default.json';
        avatarText = l10n.avatarStateActive;
    }

    return Column(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          // --- ✨ ADD AnimatedSwitcher HERE ✨ ---
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            // How long the fade takes
            transitionBuilder: (Widget child, Animation<double> animation) {
              // Use FadeTransition for a smooth fade
              return FadeTransition(opacity: animation, child: child);
            },
            child: Lottie.asset(
              lottieAssetPath,
              // The key is CRUCIAL for AnimatedSwitcher to detect changes
              key: ValueKey<String>(lottieAssetPath),
              fit: BoxFit.contain,
            ),
          ),
          // --- End AnimatedSwitcher ---
        ),
        const SizedBox(height: 16),
        // --- ✨ Animate the text change too! ✨ ---
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Text(
            avatarText,
            // The key tells AnimatedSwitcher the text content has changed
            key: ValueKey<String>(avatarText),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // --- End Text Animation ---
      ],
    );
  }
}