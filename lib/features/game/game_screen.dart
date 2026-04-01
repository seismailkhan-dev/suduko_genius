// lib/features/game/game_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/ad_banner_widget.dart';
import 'controller/game_controller.dart';
import 'widgets/game_over_dialog.dart';
import 'widgets/number_pad.dart';
import 'widgets/pause_dialog.dart';
import 'widgets/sudoku_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GameController>();

    // Show game-over dialog reactively whenever isGameOver flips to true.
    ever(ctrl.isGameOver, (bool over) {
      if (over) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.dialog(
            const GameOverDialog(),
            barrierColor: Colors.black87,
            barrierDismissible: false,
          );
        });
      }
    });

    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        await ctrl.autoSave();
        Get.offAllNamed('/home');
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              // ── App bar ─────────────────────────────────────────────────────
              _GameAppBar(),

              const SizedBox(height: 8),

              // ── Progress / timer row ────────────────────────────────────────
              _StatsRow(),

              const SizedBox(height: 16),

              // ── Board ────────────────────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SudokuBoardWidget(),
              ),

              const SizedBox(height: 20),

              // ── Number pad ──────────────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: NumberPadWidget(),
              ),

              const Spacer(),

              // ── Ad Banner ───────────────────────────────────────────────────
              const AdBannerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── App Bar ───────────────────────────────────────────────────────────────────

class _GameAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GameController>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          // Back / Home
          _IconBtn(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () async {
              await ctrl.autoSave();
              Get.offAllNamed('/home');
            },
          ),

          const SizedBox(width: 10),

          // Difficulty label
          Expanded(
            child: Obx(() => Text(
                  ctrl.difficulty.value.displayName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                )),
          ),

          // Pause button
          _IconBtn(
            icon: Icons.pause_rounded,
            onTap: PauseDialog.show,
          ),
        ],
      ),
    );
  }
}

// ── Stats row (timer + mistakes) ──────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GameController>();
    final theme = Theme.of(context);
    final mistakeColor = theme.colorScheme.error;
    final dimColor = theme.dividerColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Timer
          Obx(() {
            final secs = ctrl.elapsedSeconds.value;
            final m = secs ~/ 60;
            final s = secs % 60;
            final label =
                '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
            return Row(
              children: [
                Icon(Icons.timer_outlined, color: theme.colorScheme.primary, size: 16),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            );
          }),

          const Spacer(),

          // Mistake hearts
          Obx(() {
            final mistakes = ctrl.mistakesCount.value;
            return Row(
              children: List.generate(3, (i) {
                final filled = i < mistakes;
                return Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(
                    filled ? Icons.close_rounded : Icons.favorite_rounded,
                    color: filled ? mistakeColor : dimColor,
                    size: 18,
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }
}

// ── Shared icon button ────────────────────────────────────────────────────────

class _IconBtn extends StatelessWidget {
  const _IconBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2)),
        ),
        child: Icon(icon, color: theme.iconTheme.color, size: 18),
      ),
    );
  }
}
