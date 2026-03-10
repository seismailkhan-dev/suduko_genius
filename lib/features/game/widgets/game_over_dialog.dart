// lib/features/game/widgets/game_over_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/game_controller.dart';

/// Shown reactively when [GameController.isGameOver] becomes true.
/// Offers a 'Watch Ad' button for an extra life (once per game), then
/// only a 'New Game' button after the ad life has been used.
class GameOverDialog extends StatelessWidget {
  const GameOverDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GameController>();

    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 28),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A28),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFF1744).withValues(alpha: 0.45)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF1744).withValues(alpha: 0.20),
              blurRadius: 32,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Icon ─────────────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF1744).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sentiment_very_dissatisfied_rounded,
                  color: Color(0xFFFF1744),
                  size: 44,
                ),
              ),
              const SizedBox(height: 14),

              // ── Title ────────────────────────────────────────────────────
              const Text(
                'Game Over',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You made 3 mistakes.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 28),

              // ── Reactive buttons ─────────────────────────────────────────
              Obx(() {
                final usedAdLife = ctrl.hasUsedAdLife.value;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!usedAdLife) ...[
                      // Watch Ad → get 1 extra life
                      _GOButton(
                        label: 'Watch Ad · +1 Life',
                        icon: Icons.smart_display_rounded,
                        primary: true,
                        accentColor: const Color(0xFFFFC107),
                        onTap: () {
                          Get.back();
                          // TODO: trigger ad SDK, then call ctrl.onRewardedLifeEarned()
                          // For now we call directly so the UI is wired up:
                          ctrl.onRewardedLifeEarned();
                        },
                      ),
                      const SizedBox(height: 10),
                    ],

                    // New Game
                    _GOButton(
                      label: 'New Game',
                      icon: Icons.replay_rounded,
                      primary: usedAdLife,
                      onTap: () {
                        Get.back();
                        ctrl.startGame(ctrl.difficulty.value);
                      },
                    ),

                    const SizedBox(height: 10),

                    // Quit to Home
                    _GOButton(
                      label: 'Quit to Home',
                      icon: Icons.home_outlined,
                      onTap: () => Get.offAllNamed('/home'),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _GOButton extends StatelessWidget {
  const _GOButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.primary = false,
    this.accentColor = const Color(0xFF7C4DFF),
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? accentColor : const Color(0xFF2C2C40),
          foregroundColor: Colors.white,
          elevation: primary ? 4 : 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: primary
                ? BorderSide.none
                : const BorderSide(color: Color(0xFF3A3A50)),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
