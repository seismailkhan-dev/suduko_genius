// lib/core/db/db_service.dart

import 'app_database.dart';

/// Singleton facade that owns the [AppDatabase] instance and exposes DAOs.
class DbService {
  DbService._();

  static final DbService _instance = DbService._();

  /// The global singleton instance.
  static DbService get instance => _instance;

  late AppDatabase _db;
  bool _initialized = false;

  // ── DAO Accessors ─────────────────────────────────────────────────────────

  SavedGamesDao get savedGames => _db.savedGamesDao;
  UserStatsDao get userStats => _db.userStatsDao;
  AchievementsDao get achievements => _db.achievementsDao;
  DailyDao get daily => _db.dailyDao;
  EventDao get events => _db.eventDao;

  /// The raw database connection (use sparingly – prefer DAOs).
  AppDatabase get database => _db;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  /// Opens the database. Must be called once before any DAO usage.
  /// Subsequent calls are no-ops.
  Future<void> init() async {
    if (_initialized) return;
    _db = AppDatabase();
    _initialized = true;
  }

  /// Closes the underlying database connection.
  Future<void> close() async {
    if (!_initialized) return;
    await _db.close();
    _initialized = false;
  }
}
