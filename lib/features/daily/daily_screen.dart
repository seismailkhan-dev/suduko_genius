// lib/features/daily/daily_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'daily_controller.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  late final DailyController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.put(DailyController());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Daily Challenge',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (_ctrl.calendarData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final today = DateTime.now();
          final dateString = DateFormat('MMMM d, yyyy').format(today);

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            children: [
              // ── Header Date ──────────────────────────────────────────────
              Center(
                child: Text(
                  dateString,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // ── Main Action Card ───────────────────────────────────────
              _buildActionCard(theme),

              const SizedBox(height: 48),

              // ── Streak Flame ───────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 32))
                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .scaleXY(begin: 0.9, end: 1.1, duration: 800.ms, curve: Curves.easeInOut),
                  const SizedBox(width: 12),
                  Text(
                    '${_ctrl.streakCount.value} Day Streak',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── 30-Day Calendar Grid ───────────────────────────────────
              Text(
                'Last 30 Days',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 16),
              _buildCalendarGrid(theme),

              const SizedBox(height: 48),

              // ── Leaderboard CTA ────────────────────────────────────────
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    // TODO: Navigate to Leaderboards -> Daily Tab
                  },
                  icon: const Icon(Icons.leaderboard_rounded),
                  label: const Text('View Daily Leaderboard'),
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget _buildActionCard(ThemeData theme) {
    if (_ctrl.isDoneToday.value) {
      // Completed State
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF16A34A).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF16A34A).withValues(alpha: 0.3), width: 2),
        ),
        child: Column(
          children: [
            const Icon(Icons.emoji_events_rounded, color: Color(0xFF16A34A), size: 64)
                .animate()
                .scaleXY(begin: 0, end: 1, duration: 500.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 16),
            Text(
              'Challenge Completed!',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900, color: const Color(0xFF16A34A)),
            ),
            const SizedBox(height: 8),
            Text(
              'Next challenge in ${_ctrl.countdownString.value}',
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    } else {
      // Pending State
      final primary = theme.colorScheme.primary;
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: primary.withValues(alpha: 0.15),
              blurRadius: 24,
              offset: const Offset(0, 12),
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'MEDIUM',
                style: TextStyle(color: Color(0xFFD97706), fontWeight: FontWeight.w900, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _ctrl.startDailyChallenge,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 64),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('START CHALLENGE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1)),
            ),
            const SizedBox(height: 16),
            Text(
              'Ends in ${_ctrl.countdownString.value}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCalendarGrid(ThemeData theme) {
    // We have 30 days stored in descending order (today at index 0).
    // We want to display them chronologically left-to-right, top-to-bottom.
    // Reversing the entries gives us [29 days ago ... Today].
    final entries = _ctrl.calendarData.entries.toList().reversed.toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final status = entry.value;

        Color dotColor;
        bool isPulsing = false;
        
        switch (status) {
          case DayStatus.done:
            dotColor = const Color(0xFF16A34A); // Green
            break;
          case DayStatus.missed:
            dotColor = theme.colorScheme.error; // Red
            break;
          case DayStatus.future:
            dotColor = theme.dividerColor.withValues(alpha: 0.1); // Gray
            break;
          case DayStatus.today:
            dotColor = theme.colorScheme.primary;
            isPulsing = true;
            break;
        }

        Widget dot = Container(
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            boxShadow: status == DayStatus.done
                ? [BoxShadow(color: dotColor.withValues(alpha: 0.4), blurRadius: 4)]
                : null,
          ),
          child: Center(
            child: Text(
              '${entry.key.day}',
              style: TextStyle(
                color: status == DayStatus.future
                    ? theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.3)
                    : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );

        if (isPulsing) {
          dot = dot.animate(onPlay: (c) => c.repeat(reverse: true))
                   .scaleXY(begin: 0.9, end: 1.1, duration: 600.ms, curve: Curves.easeInOut);
        }

        return dot;
      },
    );
  }
}
