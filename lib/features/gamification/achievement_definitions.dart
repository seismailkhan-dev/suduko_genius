// lib/features/gamification/achievement_definitions.dart

import 'models/achievement_def.dart';

class AchievementDefinitions {
  static const List<AchievementDef> all = [
    // ── First Steps ──────────────────────────────────────────────────────────
    AchievementDef(id: 'first_solve', title: 'First Blood', description: 'Solve your first Sudoku puzzle.', icon: 'star'),
    AchievementDef(id: 'first_easy', title: 'Easy Peasy', description: 'Complete a puzzle on Easy difficulty.', icon: 'child_care'),
    AchievementDef(id: 'first_medium', title: 'Warming Up', description: 'Complete a puzzle on Medium difficulty.', icon: 'fitness_center'),
    AchievementDef(id: 'first_hard', title: 'Getting Serious', description: 'Complete a puzzle on Hard difficulty.', icon: 'engineering'),
    AchievementDef(id: 'first_master', title: 'Mastermind', description: 'Complete a puzzle on Master difficulty.', icon: 'psychology'),
    AchievementDef(id: 'first_extreme', title: 'Sudoku God', description: 'Complete a puzzle on Extreme difficulty.', icon: 'local_fire_department'),
    
    // ── Milestones (Volume) ──────────────────────────────────────────────────
    AchievementDef(id: 'solve_10', title: 'Dedicated', description: 'Solve 10 puzzles total.', icon: 'filter_1'),
    AchievementDef(id: 'solve_50', title: 'Enthusiast', description: 'Solve 50 puzzles total.', icon: 'filter_5'),
    AchievementDef(id: 'solve_100', title: 'Centurion', description: 'Solve 100 puzzles total.', icon: 'workspace_premium'),
    AchievementDef(id: 'solve_500', title: 'Addict', description: 'Solve 500 puzzles total.', icon: 'diamond'),
    
    // ── Perfection (No Mistakes) ─────────────────────────────────────────────
    AchievementDef(id: 'perfect_easy', title: 'Flawless Victory', description: 'Complete an Easy puzzle with 0 mistakes.', icon: 'check_circle'),
    AchievementDef(id: 'perfect_hard', title: 'Cold Calculation', description: 'Complete a Hard puzzle with 0 mistakes.', icon: 'ac_unit'),
    AchievementDef(id: 'perfect_extreme', title: 'Infallible', description: 'Complete an Extreme puzzle with 0 mistakes.', icon: 'gpp_good'),
    
    // ── Purity (No Hints) ────────────────────────────────────────────────────
    AchievementDef(id: 'no_hints_medium', title: 'Independent', description: 'Complete a Medium puzzle without using hints.', icon: 'visibility_off'),
    AchievementDef(id: 'no_hints_master', title: 'True Master', description: 'Complete a Master puzzle without using hints.', icon: 'school'),
    
    // ── Speed Runs ───────────────────────────────────────────────────────────
    AchievementDef(id: 'speed_easy_3m', title: 'Speed Demon', description: 'Solve an Easy puzzle in under 3 minutes.', icon: 'bolt'),
    AchievementDef(id: 'speed_medium_5m', title: 'Flash', description: 'Solve a Medium puzzle in under 5 minutes.', icon: 'timer'),
    AchievementDef(id: 'speed_hard_10m', title: 'Rapid Fire', description: 'Solve a Hard puzzle in under 10 minutes.', icon: 'rocket_launch'),
    
    // ── Daily Challenges & Streaks ───────────────────────────────────────────
    AchievementDef(id: 'first_daily', title: 'Daily Dose', description: 'Complete your first Daily Challenge.', icon: 'today'),
    AchievementDef(id: 'streak_3', title: 'On a Roll', description: 'Reach a 3-day Daily Challenge streak.', icon: 'local_fire_department'),
    AchievementDef(id: 'streak_7', title: 'Weekly Warrior', description: 'Reach a 7-day Daily Challenge streak.', icon: 'calendar_month'),
    AchievementDef(id: 'streak_30', title: 'Unstoppable', description: 'Reach a 30-day Daily Challenge streak.', icon: 'hotel_class'),
    
    // ── Events ───────────────────────────────────────────────────────────────
    AchievementDef(id: 'first_event', title: 'Competitor', description: 'Participate in a Seasonal Event.', icon: 'emoji_events'),
    AchievementDef(id: 'event_trophy_3', title: 'Trophy Hunter', description: 'Earn 3 trophies in Seasonal Events.', icon: 'military_tech'),
    
    // ── Progression (Leveling) ───────────────────────────────────────────────
    AchievementDef(id: 'level_5', title: 'Rising Star', description: 'Reach Level 5.', icon: 'trending_up'),
    AchievementDef(id: 'level_10', title: 'Veteran', description: 'Reach Level 10.', icon: 'military_tech'),
    AchievementDef(id: 'level_20', title: 'Grandmaster', description: 'Reach Level 20.', icon: 'emoji_events'),
    
    // ── Easter Eggs / Special ────────────────────────────────────────────────
    AchievementDef(id: 'close_call', title: 'Close Call', description: 'Finish a puzzle with 2/3 mistakes.', icon: 'warning'),
    AchievementDef(id: 'owl', title: 'Night Owl', description: 'Complete a puzzle between midnight and 4 AM.', icon: 'brightness_3'),
    AchievementDef(id: 'morning', title: 'Early Bird', description: 'Complete a puzzle between 5 AM and 8 AM.', icon: 'wb_twilight'),
  ];
}
