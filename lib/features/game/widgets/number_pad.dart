// lib/features/game/widgets/number_pad.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/game_controller.dart';

/// Bottom control panel: digit row 1–9, then erase / notes / hint buttons.
class NumberPadWidget extends StatelessWidget {
  const NumberPadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GameController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Digit row ──────────────────────────────────────────────────────
        Obx(() {
          // Count how many times each digit appears in the user grid.
          final counts = <int, int>{};
          for (final row in ctrl.userGrid) {
            for (final v in row) {
              if (v != 0) counts[v] = (counts[v] ?? 0) + 1;
            }
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(9, (i) {
              final n = i + 1;
              final complete = (counts[n] ?? 0) >= 9;
              return _DigitButton(
                digit: n,
                disabled: complete,
                onTap: complete ? null : () => ctrl.placeNumber(n),
              );
            }),
          );
        }),

        const SizedBox(height: 12),

        // ── Action row ─────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Erase
            _ActionButton(
              icon: Icons.backspace_outlined,
              label: 'Erase',
              onTap: ctrl.eraseCell,
            ),

            // Notes
            Obx(() => _ActionButton(
                  icon: Icons.edit_note_rounded,
                  label: 'Notes',
                  active: ctrl.notesMode.value,
                  onTap: ctrl.toggleNotes,
                )),

            // Hint
            Obx(() {
              final remaining = ctrl.hintsRemaining.value;
              return _ActionButton(
                icon: remaining > 0 ? Icons.lightbulb_outline : Icons.smart_display_outlined,
                label: 'Hint',
                badge: remaining > 0 ? '$remaining' : null,
                adIcon: remaining == 0,
                onTap: ctrl.useHint,
              );
            }),
          ],
        ),
      ],
    );
  }
}

// ── Digit button ──────────────────────────────────────────────────────────────

class _DigitButton extends StatelessWidget {
  const _DigitButton({
    required this.digit,
    required this.disabled,
    this.onTap,
  });

  final int digit;
  final bool disabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;
    final disabledBgColor = theme.dividerColor.withValues(alpha: 0.05);
    final activeBgColor = theme.cardTheme.color ?? theme.scaffoldBackgroundColor;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 36,
        height: 52,
        decoration: BoxDecoration(
          color: disabled ? disabledBgColor : activeBgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: disabled
                ? theme.dividerColor.withValues(alpha: 0.2)
                : accentColor.withValues(alpha: 0.40),
            width: 1,
          ),
          boxShadow: disabled
              ? null
              : [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            '$digit',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: disabled
                  ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.3)
                  : theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Action button ─────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    this.badge,
    this.adIcon = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;
  final String? badge;
  final bool adIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;
    final color = active ? accentColor : theme.iconTheme.color?.withValues(alpha: 0.5) ?? Colors.grey;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: active
              ? accentColor.withValues(alpha: 0.18)
              : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? accentColor : theme.dividerColor.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 22),
                if (badge != null)
                  Positioned(
                    top: -6,
                    right: -10,
                    child: Container(
                      padding: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (adIcon)
                  Positioned(
                    top: -5,
                    right: -9,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFC107),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow, size: 9, color: Colors.black),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
