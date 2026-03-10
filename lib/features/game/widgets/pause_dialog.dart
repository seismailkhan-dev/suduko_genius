// lib/features/game/widgets/pause_dialog.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/game_controller.dart';

/// Semi-transparent overlay displayed when the game is paused.
/// Not a new route — displayed via [showGeneralDialog] or [Get.dialog].
class PauseDialog extends StatelessWidget {
  const PauseDialog({super.key});

  static void show() {
    final ctrl = Get.find<GameController>();
    ctrl.pauseGame();
    Get.dialog(
      const PauseDialog(),
      barrierColor: Colors.black87,
      barrierDismissible: false,
    );
  }

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
          border: Border.all(color: const Color(0xFF7C4DFF).withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C4DFF).withValues(alpha: 0.25),
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
              // ── Icon + Title ─────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C4DFF).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.pause_circle_outline_rounded,
                  color: Color(0xFF7C4DFF),
                  size: 40,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Game Paused',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 28),

              // ── Buttons ──────────────────────────────────────────────────
              _PauseButton(
                label: 'Resume',
                icon: Icons.play_arrow_rounded,
                primary: true,
                onTap: () {
                  Get.back();
                  ctrl.resumeGame();
                },
              ),
              const SizedBox(height: 10),
              _PauseButton(
                label: 'Restart',
                icon: Icons.replay_rounded,
                onTap: () {
                  Get.back();
                  Get.defaultDialog(
                    title: 'Restart?',
                    middleText: 'Your current progress will be lost.',
                    barrierDismissible: true,
                    textConfirm: 'Restart',
                    textCancel: 'Cancel',
                    confirmTextColor: Colors.white,
                    buttonColor: const Color(0xFF7C4DFF),
                    onConfirm: () {
                      Get.back();
                      ctrl.startGame(ctrl.difficulty.value);
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              _PauseButton(
                label: 'Settings',
                icon: Icons.settings_outlined,
                onTap: () {
                  Get.back();
                  ctrl.resumeGame();
                  Get.toNamed('/settings');
                },
              ),
              const SizedBox(height: 10),
              _PauseButton(
                label: 'Quit to Home',
                icon: Icons.home_outlined,
                onTap: () async {
                  await ctrl.autoSave();
                  Get.offAllNamed('/home');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PauseButton extends StatelessWidget {
  const _PauseButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.primary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary
              ? const Color(0xFF7C4DFF)
              : const Color(0xFF2C2C40),
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
