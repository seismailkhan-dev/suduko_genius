// lib/core/db/app_database.dart
//
// Run `flutter pub run build_runner build --delete-conflicting-outputs`
// after editing this file to regenerate the `.g.dart` companion file.

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/gamification/achievement_definitions.dart';
import '../../features/gamification/level_service.dart';

part 'app_database.g.dart';

// ── Table definitions ─────────────────────────────────────────────────────────

/// Persisted game sessions (in-progress or completed).
class SavedGames extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// JSON-encoded 9×9 puzzle grid.
  TextColumn get puzzle => text()();

  /// JSON-encoded 9×9 user-filled grid.
  TextColumn get userGrid => text()();

  /// JSON-encoded 9×9 solution grid.
  TextColumn get solution => text()();

  TextColumn get difficulty => text()();

  IntColumn get elapsedSeconds => integer().withDefault(const Constant(0))();

  IntColumn get hintsUsed => integer().withDefault(const Constant(0))();

  IntColumn get mistakes => integer().withDefault(const Constant(0))();

  /// JSON-encoded notes map: `{ "r,c": [1,3,7], ... }`.
  TextColumn get notesJson =>
      text().withDefault(const Constant('{}'))();

  TextColumn get createdAt => text()();

  TextColumn get updatedAt => text()();
}

/// Aggregated statistics per user (single row).
class UserStats extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get totalXP => integer().withDefault(const Constant(0))();

  IntColumn get level => integer().withDefault(const Constant(1))();

  IntColumn get streakDays => integer().withDefault(const Constant(0))();

  /// ISO date string of the last session, e.g. "2024-03-10".
  TextColumn get lastPlayedDate =>
      text().withDefault(const Constant(''))();

  /// JSON map: `{ "easy": 5, "medium": 3, ... }`.
  TextColumn get puzzlesPerDifficulty =>
      text().withDefault(const Constant('{}'))();

  /// JSON map: `{ "easy": 120, "medium": 300, ... }` (best seconds).
  TextColumn get bestTimesJson =>
      text().withDefault(const Constant('{}'))();

  IntColumn get totalMistakes =>
      integer().withDefault(const Constant(0))();

  IntColumn get totalHints =>
      integer().withDefault(const Constant(0))();
}

/// Unlockable achievements.
class Achievements extends Table {
  /// e.g. "first_solve", "no_mistakes_easy".
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  /// Icon identifier (e.g. Material icon name or asset path).
  TextColumn get icon => text()();

  /// ISO 8601 unlock timestamp; null when locked.
  TextColumn get unlockedAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// One row per completed daily puzzle.
class DailyCompletions extends Table {
  /// ISO date string, e.g. "2024-03-10".
  TextColumn get date => text()();

  TextColumn get difficulty => text()();

  IntColumn get timeSeconds => integer()();

  IntColumn get mistakes => integer().withDefault(const Constant(0))();

  IntColumn get hintsUsed => integer().withDefault(const Constant(0))();

  IntColumn get xpEarned => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {date};
}

/// Progress tracker for timed / seasonal events.
class EventProgress extends Table {
  TextColumn get eventId => text()();

  IntColumn get trophiesEarned =>
      integer().withDefault(const Constant(0))();

  IntColumn get puzzlesDone =>
      integer().withDefault(const Constant(0))();

  TextColumn get claimedMilestonesJson =>
      text().withDefault(const Constant('[]'))();

  TextColumn get updatedAt =>
      text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {eventId};
}

// ── DAOs ──────────────────────────────────────────────────────────────────────

@DriftAccessor(tables: [SavedGames])
class SavedGamesDao extends DatabaseAccessor<AppDatabase>
    with _$SavedGamesDaoMixin {
  SavedGamesDao(super.db);

  Future<List<SavedGame>> getAllGames() => select(savedGames).get();

  Stream<List<SavedGame>> watchAllGames() => select(savedGames).watch();

  Future<SavedGame?> getGameById(int id) =>
      (select(savedGames)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertGame(SavedGamesCompanion entry) =>
      into(savedGames).insert(entry);

  Future<bool> updateGame(SavedGamesCompanion entry) =>
      update(savedGames).replace(entry);

  Future<int> deleteGame(int id) =>
      (delete(savedGames)..where((t) => t.id.equals(id))).go();

  Future<int> deleteAllGames() => delete(savedGames).go();

  Future<List<SavedGame>> getGamesByDifficulty(String difficulty) =>
      (select(savedGames)
            ..where((t) => t.difficulty.equals(difficulty)))
          .get();
}

@DriftAccessor(tables: [UserStats])
class UserStatsDao extends DatabaseAccessor<AppDatabase>
    with _$UserStatsDaoMixin {
  UserStatsDao(super.db);

  Future<UserStat?> getStats() =>
      select(userStats).getSingleOrNull();

  Stream<UserStat?> watchStats() =>
      select(userStats).watchSingleOrNull();

  Future<int> insertStats(UserStatsCompanion entry) =>
      into(userStats).insert(entry);

  Future<bool> updateStats(UserStatsCompanion entry) =>
      update(userStats).replace(entry);

  /// Atomically increments XP and recalculates level using LevelService.
  Future<void> addXP(int xp) async {
    await transaction(() async {
      final current = await getStats();
      if (current == null) {
        await insertStats(UserStatsCompanion(
          totalXP: Value(xp),
          level: Value(LevelService.getLevel(xp)),
        ));
        return;
      }
      final newXP = current.totalXP + xp;
      await updateStats(current
          .toCompanion(true)
          .copyWith(
            totalXP: Value(newXP),
            level: Value(LevelService.getLevel(newXP)),
          ));
    });
  }

  /// Increments the total mistakes and hints
  Future<void> incrementMistakesAndHints(int mistakes, int hints) async {
    await transaction(() async {
      final current = await getStats();
      if (current == null) {
        await insertStats(UserStatsCompanion(
          totalMistakes: Value(mistakes),
          totalHints: Value(hints),
        ));
      } else {
        await updateStats(current.toCompanion(true).copyWith(
          totalMistakes: Value(current.totalMistakes + mistakes),
          totalHints: Value(current.totalHints + hints),
        ));
      }
    });
  }

  /// Updates the per-difficulty puzzle count map.
  Future<void> incrementPuzzleCount(String difficulty) async {
    await transaction(() async {
      final current = await getStats();
      final raw = current?.puzzlesPerDifficulty ?? '{}';
      final map = Map<String, int>.from(
        (jsonDecode(raw) as Map).map((k, v) => MapEntry(k as String, v as int)),
      );
      map[difficulty] = (map[difficulty] ?? 0) + 1;
      final companion = current == null
          ? UserStatsCompanion(puzzlesPerDifficulty: Value(jsonEncode(map)))
          : current
              .toCompanion(true)
              .copyWith(puzzlesPerDifficulty: Value(jsonEncode(map)));
      if (current == null) {
        await insertStats(companion);
      } else {
        await updateStats(companion);
      }
    });
  }
}

@DriftAccessor(tables: [Achievements])
class AchievementsDao extends DatabaseAccessor<AppDatabase>
    with _$AchievementsDaoMixin {
  AchievementsDao(super.db);

  Future<List<Achievement>> getAll() => select(achievements).get();

  Stream<List<Achievement>> watchAll() => select(achievements).watch();

  Future<Achievement?> getById(String id) =>
      (select(achievements)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insert(AchievementsCompanion entry) =>
      into(achievements).insertOnConflictUpdate(entry);

  Future<bool> unlock(String id) async {
    final rows = await (update(achievements)..where((t) => t.id.equals(id)))
        .write(AchievementsCompanion(
      unlockedAt: Value(DateTime.now().toIso8601String()),
    ));
    return rows > 0;
  }

  Future<List<Achievement>> getUnlocked() =>
      (select(achievements)
            ..where((t) => t.unlockedAt.isNotNull()))
          .get();
}

@DriftAccessor(tables: [DailyCompletions])
class DailyDao extends DatabaseAccessor<AppDatabase> with _$DailyDaoMixin {
  DailyDao(super.db);

  Future<DailyCompletion?> getByDate(String date) =>
      (select(dailyCompletions)..where((t) => t.date.equals(date)))
          .getSingleOrNull();

  Future<List<DailyCompletion>> getAll() =>
      select(dailyCompletions).get();

  Future<int> insert(DailyCompletionsCompanion entry) =>
      into(dailyCompletions).insertOnConflictUpdate(entry);

  Future<bool> isCompleted(String date) async {
    final row = await getByDate(date);
    return row != null;
  }
}

@DriftAccessor(tables: [EventProgress])
class EventDao extends DatabaseAccessor<AppDatabase> with _$EventDaoMixin {
  EventDao(super.db);

  Future<EventProgressData?> getByEventId(String eventId) =>
      (select(eventProgress)
            ..where((t) => t.eventId.equals(eventId)))
          .getSingleOrNull();

  Future<List<EventProgressData>> getAll() => select(eventProgress).get();

  Future<int> upsert(EventProgressCompanion entry) =>
      into(eventProgress).insertOnConflictUpdate(entry);

  Future<void> addTrophy(String eventId) async {
    await transaction(() async {
      final current = await getByEventId(eventId);
      if (current == null) {
        await upsert(EventProgressCompanion(
          eventId: Value(eventId),
          trophiesEarned: const Value(1),
        ));
      } else {
        await upsert(current.toCompanion(true).copyWith(
              trophiesEarned: Value(current.trophiesEarned + 1),
            ));
      }
    });
  }

  Future<void> incrementPuzzlesDone(String eventId) async {
    await transaction(() async {
      final current = await getByEventId(eventId);
      if (current == null) {
        await upsert(EventProgressCompanion(
          eventId: Value(eventId),
          puzzlesDone: const Value(1),
        ));
      } else {
        await upsert(current.toCompanion(true).copyWith(
              puzzlesDone: Value(current.puzzlesDone + 1),
            ));
      }
    });
  }
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(
  tables: [SavedGames, UserStats, Achievements, DailyCompletions, EventProgress],
  daos: [SavedGamesDao, UserStatsDao, AchievementsDao, DailyDao, EventDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'sudoku_app'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed achievements on first run
          for (final def in AchievementDefinitions.all) {
            await into(achievements).insert(AchievementsCompanion.insert(
              id: def.id,
              title: def.title,
              description: def.description,
              icon: def.icon,
            ));
          }
        },
        onUpgrade: (m, from, to) async {
          // Future migrations go here.
        },
      );
}
