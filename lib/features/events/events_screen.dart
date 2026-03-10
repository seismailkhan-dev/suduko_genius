// lib/features/events/events_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'event_controller.dart';
import 'event_model.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late final EventController _ctrl;

  @override
  void initState() {
    super.initState();
    // Putting controller if it's not already instantiated
    // (This ensures when we navigate to tab or screen, data is there)
    _ctrl = Get.put(EventController()); 
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
          'Events',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final ev = _ctrl.activeEvent.value;

          if (ev == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.event_busy_rounded, size: 80, color: theme.dividerColor.withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'No active event\nCheck back soon!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          }

          // We have an active event
          final totalTrophies = _ctrl.trophiesEarned.value;
          final maxTrophies = ev.milestones.isNotEmpty
              ? ev.milestones.last.trophiesRequired
              : 1;
          final progressRatio = (totalTrophies / maxTrophies).clamp(0.0, 1.0);

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            children: [
              // ── Banner ─────────────────────────────────────────────────────
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.7),
                      theme.colorScheme.primary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                     BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 8))
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      bottom: -20,
                      child: const Icon(Icons.emoji_events_rounded, color: Colors.white24, size: 200),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'LIVE NOW',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 0.8),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            ev.name,
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, height: 1.1),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ends in ${_ctrl.countdownString.value}',
                            style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(begin: 0.1, end: 0, duration: 600.ms, curve: Curves.easeOut).fadeIn(),

              const SizedBox(height: 24),
              Text(ev.description, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
              const SizedBox(height: 32),

              // ── Progress Bar ───────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Progress', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                  Text(
                    '$totalTrophies / $maxTrophies Trophies',
                    style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progressRatio,
                  minHeight: 12,
                  backgroundColor: theme.dividerColor.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
                ),
              ),

              const SizedBox(height: 48),

              // ── Milestones ─────────────────────────────────────────────────
              Text('Rewards', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              
              Column(
                children: List.generate(ev.milestones.length, (index) {
                  final ms = ev.milestones[index];
                  final isClaimed = _ctrl.milestoneStatuses.length > index && _ctrl.milestoneStatuses[index];
                  final isUnlocked = totalTrophies >= ms.trophiesRequired;
                  
                  return _buildMilestoneRow(ms, isUnlocked, isClaimed, index, theme);
                }),
              ),

              const SizedBox(height: 40),

              // ── Play CTA ───────────────────────────────────────────────────
              ElevatedButton(
                onPressed: () => Get.toNamed('/difficulty'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 64),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('PLAY NOW', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, letterSpacing: 1)),
              ).animate().slideY(begin: 0.2, end: 0, delay: 200.ms).fadeIn(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMilestoneRow(EventMilestone ms, bool isUnlocked, bool isClaimed, int index, ThemeData theme) {
    Color cardColor;
    Color iconBg;
    if (isClaimed) {
      cardColor = const Color(0xFF16A34A).withValues(alpha: 0.1);
      iconBg = const Color(0xFF16A34A).withValues(alpha: 0.2);
    } else if (isUnlocked) {
      cardColor = theme.colorScheme.primary.withValues(alpha: 0.1);
      iconBg = theme.colorScheme.primary.withValues(alpha: 0.2);
    } else {
      cardColor = theme.cardTheme.color ?? theme.scaffoldBackgroundColor;
      iconBg = theme.dividerColor.withValues(alpha: 0.1);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          if (isUnlocked && !isClaimed) _showRewardDialog(index, ms);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isUnlocked && !isClaimed 
                  ? theme.colorScheme.primary.withValues(alpha: 0.3) 
                  : theme.dividerColor.withValues(alpha: 0.05),
              width: isUnlocked && !isClaimed ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Center(
                  child: Text(ms.rewardIcon, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ms.rewardName, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text(
                      '${ms.trophiesRequired} Trophies',
                      style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600, color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6)),
                    ),
                  ],
                ),
              ),
              if (isClaimed)
                const Icon(Icons.check_circle_rounded, color: Color(0xFF16A34A), size: 28)
              else if (isUnlocked)
                 Text('CLAIM', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w900))
              else
                 Icon(Icons.lock_rounded, color: theme.dividerColor.withValues(alpha: 0.4), size: 24)
            ],
          ),
        ),
      ),
    );
  }

  void _showRewardDialog(int index, EventMilestone ms) {
    _ctrl.claimMilestone(index);
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(ms.rewardIcon, style: const TextStyle(fontSize: 80))
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scaleXY(begin: 0.9, end: 1.1, duration: 600.ms),
              const SizedBox(height: 24),
              const Text('Reward Unlocked!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('You received the ${ms.rewardName}.', textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('Awesome', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ).animate().scale(curve: Curves.easeOutBack, duration: 300.ms),
      barrierDismissible: false,
    );
  }
}
