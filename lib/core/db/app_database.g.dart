// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
mixin _$SavedGamesDaoMixin on DatabaseAccessor<AppDatabase> {
  $SavedGamesTable get savedGames => attachedDatabase.savedGames;
  SavedGamesDaoManager get managers => SavedGamesDaoManager(this);
}

class SavedGamesDaoManager {
  final _$SavedGamesDaoMixin _db;
  SavedGamesDaoManager(this._db);
  $$SavedGamesTableTableManager get savedGames =>
      $$SavedGamesTableTableManager(_db.attachedDatabase, _db.savedGames);
}

mixin _$UserStatsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserStatsTable get userStats => attachedDatabase.userStats;
  UserStatsDaoManager get managers => UserStatsDaoManager(this);
}

class UserStatsDaoManager {
  final _$UserStatsDaoMixin _db;
  UserStatsDaoManager(this._db);
  $$UserStatsTableTableManager get userStats =>
      $$UserStatsTableTableManager(_db.attachedDatabase, _db.userStats);
}

mixin _$AchievementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AchievementsTable get achievements => attachedDatabase.achievements;
  AchievementsDaoManager get managers => AchievementsDaoManager(this);
}

class AchievementsDaoManager {
  final _$AchievementsDaoMixin _db;
  AchievementsDaoManager(this._db);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db.attachedDatabase, _db.achievements);
}

mixin _$DailyDaoMixin on DatabaseAccessor<AppDatabase> {
  $DailyCompletionsTable get dailyCompletions =>
      attachedDatabase.dailyCompletions;
  DailyDaoManager get managers => DailyDaoManager(this);
}

class DailyDaoManager {
  final _$DailyDaoMixin _db;
  DailyDaoManager(this._db);
  $$DailyCompletionsTableTableManager get dailyCompletions =>
      $$DailyCompletionsTableTableManager(
        _db.attachedDatabase,
        _db.dailyCompletions,
      );
}

mixin _$EventDaoMixin on DatabaseAccessor<AppDatabase> {
  $EventProgressTable get eventProgress => attachedDatabase.eventProgress;
  EventDaoManager get managers => EventDaoManager(this);
}

class EventDaoManager {
  final _$EventDaoMixin _db;
  EventDaoManager(this._db);
  $$EventProgressTableTableManager get eventProgress =>
      $$EventProgressTableTableManager(_db.attachedDatabase, _db.eventProgress);
}

class $SavedGamesTable extends SavedGames
    with TableInfo<$SavedGamesTable, SavedGame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _puzzleMeta = const VerificationMeta('puzzle');
  @override
  late final GeneratedColumn<String> puzzle = GeneratedColumn<String>(
    'puzzle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userGridMeta = const VerificationMeta(
    'userGrid',
  );
  @override
  late final GeneratedColumn<String> userGrid = GeneratedColumn<String>(
    'user_grid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _solutionMeta = const VerificationMeta(
    'solution',
  );
  @override
  late final GeneratedColumn<String> solution = GeneratedColumn<String>(
    'solution',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _elapsedSecondsMeta = const VerificationMeta(
    'elapsedSeconds',
  );
  @override
  late final GeneratedColumn<int> elapsedSeconds = GeneratedColumn<int>(
    'elapsed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hintsUsedMeta = const VerificationMeta(
    'hintsUsed',
  );
  @override
  late final GeneratedColumn<int> hintsUsed = GeneratedColumn<int>(
    'hints_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mistakesMeta = const VerificationMeta(
    'mistakes',
  );
  @override
  late final GeneratedColumn<int> mistakes = GeneratedColumn<int>(
    'mistakes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesJsonMeta = const VerificationMeta(
    'notesJson',
  );
  @override
  late final GeneratedColumn<String> notesJson = GeneratedColumn<String>(
    'notes_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    puzzle,
    userGrid,
    solution,
    difficulty,
    elapsedSeconds,
    hintsUsed,
    mistakes,
    notesJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_games';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedGame> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('puzzle')) {
      context.handle(
        _puzzleMeta,
        puzzle.isAcceptableOrUnknown(data['puzzle']!, _puzzleMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleMeta);
    }
    if (data.containsKey('user_grid')) {
      context.handle(
        _userGridMeta,
        userGrid.isAcceptableOrUnknown(data['user_grid']!, _userGridMeta),
      );
    } else if (isInserting) {
      context.missing(_userGridMeta);
    }
    if (data.containsKey('solution')) {
      context.handle(
        _solutionMeta,
        solution.isAcceptableOrUnknown(data['solution']!, _solutionMeta),
      );
    } else if (isInserting) {
      context.missing(_solutionMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('elapsed_seconds')) {
      context.handle(
        _elapsedSecondsMeta,
        elapsedSeconds.isAcceptableOrUnknown(
          data['elapsed_seconds']!,
          _elapsedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('hints_used')) {
      context.handle(
        _hintsUsedMeta,
        hintsUsed.isAcceptableOrUnknown(data['hints_used']!, _hintsUsedMeta),
      );
    }
    if (data.containsKey('mistakes')) {
      context.handle(
        _mistakesMeta,
        mistakes.isAcceptableOrUnknown(data['mistakes']!, _mistakesMeta),
      );
    }
    if (data.containsKey('notes_json')) {
      context.handle(
        _notesJsonMeta,
        notesJson.isAcceptableOrUnknown(data['notes_json']!, _notesJsonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedGame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedGame(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      puzzle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle'],
      )!,
      userGrid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_grid'],
      )!,
      solution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solution'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      elapsedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_seconds'],
      )!,
      hintsUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hints_used'],
      )!,
      mistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistakes'],
      )!,
      notesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SavedGamesTable createAlias(String alias) {
    return $SavedGamesTable(attachedDatabase, alias);
  }
}

class SavedGame extends DataClass implements Insertable<SavedGame> {
  final int id;

  /// JSON-encoded 9×9 puzzle grid.
  final String puzzle;

  /// JSON-encoded 9×9 user-filled grid.
  final String userGrid;

  /// JSON-encoded 9×9 solution grid.
  final String solution;
  final String difficulty;
  final int elapsedSeconds;
  final int hintsUsed;
  final int mistakes;

  /// JSON-encoded notes map: `{ "r,c": [1,3,7], ... }`.
  final String notesJson;
  final String createdAt;
  final String updatedAt;
  const SavedGame({
    required this.id,
    required this.puzzle,
    required this.userGrid,
    required this.solution,
    required this.difficulty,
    required this.elapsedSeconds,
    required this.hintsUsed,
    required this.mistakes,
    required this.notesJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['puzzle'] = Variable<String>(puzzle);
    map['user_grid'] = Variable<String>(userGrid);
    map['solution'] = Variable<String>(solution);
    map['difficulty'] = Variable<String>(difficulty);
    map['elapsed_seconds'] = Variable<int>(elapsedSeconds);
    map['hints_used'] = Variable<int>(hintsUsed);
    map['mistakes'] = Variable<int>(mistakes);
    map['notes_json'] = Variable<String>(notesJson);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  SavedGamesCompanion toCompanion(bool nullToAbsent) {
    return SavedGamesCompanion(
      id: Value(id),
      puzzle: Value(puzzle),
      userGrid: Value(userGrid),
      solution: Value(solution),
      difficulty: Value(difficulty),
      elapsedSeconds: Value(elapsedSeconds),
      hintsUsed: Value(hintsUsed),
      mistakes: Value(mistakes),
      notesJson: Value(notesJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavedGame.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedGame(
      id: serializer.fromJson<int>(json['id']),
      puzzle: serializer.fromJson<String>(json['puzzle']),
      userGrid: serializer.fromJson<String>(json['userGrid']),
      solution: serializer.fromJson<String>(json['solution']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      elapsedSeconds: serializer.fromJson<int>(json['elapsedSeconds']),
      hintsUsed: serializer.fromJson<int>(json['hintsUsed']),
      mistakes: serializer.fromJson<int>(json['mistakes']),
      notesJson: serializer.fromJson<String>(json['notesJson']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'puzzle': serializer.toJson<String>(puzzle),
      'userGrid': serializer.toJson<String>(userGrid),
      'solution': serializer.toJson<String>(solution),
      'difficulty': serializer.toJson<String>(difficulty),
      'elapsedSeconds': serializer.toJson<int>(elapsedSeconds),
      'hintsUsed': serializer.toJson<int>(hintsUsed),
      'mistakes': serializer.toJson<int>(mistakes),
      'notesJson': serializer.toJson<String>(notesJson),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  SavedGame copyWith({
    int? id,
    String? puzzle,
    String? userGrid,
    String? solution,
    String? difficulty,
    int? elapsedSeconds,
    int? hintsUsed,
    int? mistakes,
    String? notesJson,
    String? createdAt,
    String? updatedAt,
  }) => SavedGame(
    id: id ?? this.id,
    puzzle: puzzle ?? this.puzzle,
    userGrid: userGrid ?? this.userGrid,
    solution: solution ?? this.solution,
    difficulty: difficulty ?? this.difficulty,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    hintsUsed: hintsUsed ?? this.hintsUsed,
    mistakes: mistakes ?? this.mistakes,
    notesJson: notesJson ?? this.notesJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SavedGame copyWithCompanion(SavedGamesCompanion data) {
    return SavedGame(
      id: data.id.present ? data.id.value : this.id,
      puzzle: data.puzzle.present ? data.puzzle.value : this.puzzle,
      userGrid: data.userGrid.present ? data.userGrid.value : this.userGrid,
      solution: data.solution.present ? data.solution.value : this.solution,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      elapsedSeconds: data.elapsedSeconds.present
          ? data.elapsedSeconds.value
          : this.elapsedSeconds,
      hintsUsed: data.hintsUsed.present ? data.hintsUsed.value : this.hintsUsed,
      mistakes: data.mistakes.present ? data.mistakes.value : this.mistakes,
      notesJson: data.notesJson.present ? data.notesJson.value : this.notesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedGame(')
          ..write('id: $id, ')
          ..write('puzzle: $puzzle, ')
          ..write('userGrid: $userGrid, ')
          ..write('solution: $solution, ')
          ..write('difficulty: $difficulty, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('mistakes: $mistakes, ')
          ..write('notesJson: $notesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    puzzle,
    userGrid,
    solution,
    difficulty,
    elapsedSeconds,
    hintsUsed,
    mistakes,
    notesJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedGame &&
          other.id == this.id &&
          other.puzzle == this.puzzle &&
          other.userGrid == this.userGrid &&
          other.solution == this.solution &&
          other.difficulty == this.difficulty &&
          other.elapsedSeconds == this.elapsedSeconds &&
          other.hintsUsed == this.hintsUsed &&
          other.mistakes == this.mistakes &&
          other.notesJson == this.notesJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavedGamesCompanion extends UpdateCompanion<SavedGame> {
  final Value<int> id;
  final Value<String> puzzle;
  final Value<String> userGrid;
  final Value<String> solution;
  final Value<String> difficulty;
  final Value<int> elapsedSeconds;
  final Value<int> hintsUsed;
  final Value<int> mistakes;
  final Value<String> notesJson;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const SavedGamesCompanion({
    this.id = const Value.absent(),
    this.puzzle = const Value.absent(),
    this.userGrid = const Value.absent(),
    this.solution = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.notesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SavedGamesCompanion.insert({
    this.id = const Value.absent(),
    required String puzzle,
    required String userGrid,
    required String solution,
    required String difficulty,
    this.elapsedSeconds = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.notesJson = const Value.absent(),
    required String createdAt,
    required String updatedAt,
  }) : puzzle = Value(puzzle),
       userGrid = Value(userGrid),
       solution = Value(solution),
       difficulty = Value(difficulty),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SavedGame> custom({
    Expression<int>? id,
    Expression<String>? puzzle,
    Expression<String>? userGrid,
    Expression<String>? solution,
    Expression<String>? difficulty,
    Expression<int>? elapsedSeconds,
    Expression<int>? hintsUsed,
    Expression<int>? mistakes,
    Expression<String>? notesJson,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (puzzle != null) 'puzzle': puzzle,
      if (userGrid != null) 'user_grid': userGrid,
      if (solution != null) 'solution': solution,
      if (difficulty != null) 'difficulty': difficulty,
      if (elapsedSeconds != null) 'elapsed_seconds': elapsedSeconds,
      if (hintsUsed != null) 'hints_used': hintsUsed,
      if (mistakes != null) 'mistakes': mistakes,
      if (notesJson != null) 'notes_json': notesJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SavedGamesCompanion copyWith({
    Value<int>? id,
    Value<String>? puzzle,
    Value<String>? userGrid,
    Value<String>? solution,
    Value<String>? difficulty,
    Value<int>? elapsedSeconds,
    Value<int>? hintsUsed,
    Value<int>? mistakes,
    Value<String>? notesJson,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return SavedGamesCompanion(
      id: id ?? this.id,
      puzzle: puzzle ?? this.puzzle,
      userGrid: userGrid ?? this.userGrid,
      solution: solution ?? this.solution,
      difficulty: difficulty ?? this.difficulty,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      mistakes: mistakes ?? this.mistakes,
      notesJson: notesJson ?? this.notesJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (puzzle.present) {
      map['puzzle'] = Variable<String>(puzzle.value);
    }
    if (userGrid.present) {
      map['user_grid'] = Variable<String>(userGrid.value);
    }
    if (solution.present) {
      map['solution'] = Variable<String>(solution.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (elapsedSeconds.present) {
      map['elapsed_seconds'] = Variable<int>(elapsedSeconds.value);
    }
    if (hintsUsed.present) {
      map['hints_used'] = Variable<int>(hintsUsed.value);
    }
    if (mistakes.present) {
      map['mistakes'] = Variable<int>(mistakes.value);
    }
    if (notesJson.present) {
      map['notes_json'] = Variable<String>(notesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedGamesCompanion(')
          ..write('id: $id, ')
          ..write('puzzle: $puzzle, ')
          ..write('userGrid: $userGrid, ')
          ..write('solution: $solution, ')
          ..write('difficulty: $difficulty, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('mistakes: $mistakes, ')
          ..write('notesJson: $notesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserStatsTable extends UserStats
    with TableInfo<$UserStatsTable, UserStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _totalXPMeta = const VerificationMeta(
    'totalXP',
  );
  @override
  late final GeneratedColumn<int> totalXP = GeneratedColumn<int>(
    'total_x_p',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _streakDaysMeta = const VerificationMeta(
    'streakDays',
  );
  @override
  late final GeneratedColumn<int> streakDays = GeneratedColumn<int>(
    'streak_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastPlayedDateMeta = const VerificationMeta(
    'lastPlayedDate',
  );
  @override
  late final GeneratedColumn<String> lastPlayedDate = GeneratedColumn<String>(
    'last_played_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _puzzlesPerDifficultyMeta =
      const VerificationMeta('puzzlesPerDifficulty');
  @override
  late final GeneratedColumn<String> puzzlesPerDifficulty =
      GeneratedColumn<String>(
        'puzzles_per_difficulty',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _bestTimesJsonMeta = const VerificationMeta(
    'bestTimesJson',
  );
  @override
  late final GeneratedColumn<String> bestTimesJson = GeneratedColumn<String>(
    'best_times_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _totalMistakesMeta = const VerificationMeta(
    'totalMistakes',
  );
  @override
  late final GeneratedColumn<int> totalMistakes = GeneratedColumn<int>(
    'total_mistakes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalHintsMeta = const VerificationMeta(
    'totalHints',
  );
  @override
  late final GeneratedColumn<int> totalHints = GeneratedColumn<int>(
    'total_hints',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    totalXP,
    level,
    streakDays,
    lastPlayedDate,
    puzzlesPerDifficulty,
    bestTimesJson,
    totalMistakes,
    totalHints,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('total_x_p')) {
      context.handle(
        _totalXPMeta,
        totalXP.isAcceptableOrUnknown(data['total_x_p']!, _totalXPMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('streak_days')) {
      context.handle(
        _streakDaysMeta,
        streakDays.isAcceptableOrUnknown(data['streak_days']!, _streakDaysMeta),
      );
    }
    if (data.containsKey('last_played_date')) {
      context.handle(
        _lastPlayedDateMeta,
        lastPlayedDate.isAcceptableOrUnknown(
          data['last_played_date']!,
          _lastPlayedDateMeta,
        ),
      );
    }
    if (data.containsKey('puzzles_per_difficulty')) {
      context.handle(
        _puzzlesPerDifficultyMeta,
        puzzlesPerDifficulty.isAcceptableOrUnknown(
          data['puzzles_per_difficulty']!,
          _puzzlesPerDifficultyMeta,
        ),
      );
    }
    if (data.containsKey('best_times_json')) {
      context.handle(
        _bestTimesJsonMeta,
        bestTimesJson.isAcceptableOrUnknown(
          data['best_times_json']!,
          _bestTimesJsonMeta,
        ),
      );
    }
    if (data.containsKey('total_mistakes')) {
      context.handle(
        _totalMistakesMeta,
        totalMistakes.isAcceptableOrUnknown(
          data['total_mistakes']!,
          _totalMistakesMeta,
        ),
      );
    }
    if (data.containsKey('total_hints')) {
      context.handle(
        _totalHintsMeta,
        totalHints.isAcceptableOrUnknown(data['total_hints']!, _totalHintsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserStat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      totalXP: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_x_p'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      streakDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_days'],
      )!,
      lastPlayedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_played_date'],
      )!,
      puzzlesPerDifficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzles_per_difficulty'],
      )!,
      bestTimesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}best_times_json'],
      )!,
      totalMistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_mistakes'],
      )!,
      totalHints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_hints'],
      )!,
    );
  }

  @override
  $UserStatsTable createAlias(String alias) {
    return $UserStatsTable(attachedDatabase, alias);
  }
}

class UserStat extends DataClass implements Insertable<UserStat> {
  final int id;
  final int totalXP;
  final int level;
  final int streakDays;

  /// ISO date string of the last session, e.g. "2024-03-10".
  final String lastPlayedDate;

  /// JSON map: `{ "easy": 5, "medium": 3, ... }`.
  final String puzzlesPerDifficulty;

  /// JSON map: `{ "easy": 120, "medium": 300, ... }` (best seconds).
  final String bestTimesJson;
  final int totalMistakes;
  final int totalHints;
  const UserStat({
    required this.id,
    required this.totalXP,
    required this.level,
    required this.streakDays,
    required this.lastPlayedDate,
    required this.puzzlesPerDifficulty,
    required this.bestTimesJson,
    required this.totalMistakes,
    required this.totalHints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['total_x_p'] = Variable<int>(totalXP);
    map['level'] = Variable<int>(level);
    map['streak_days'] = Variable<int>(streakDays);
    map['last_played_date'] = Variable<String>(lastPlayedDate);
    map['puzzles_per_difficulty'] = Variable<String>(puzzlesPerDifficulty);
    map['best_times_json'] = Variable<String>(bestTimesJson);
    map['total_mistakes'] = Variable<int>(totalMistakes);
    map['total_hints'] = Variable<int>(totalHints);
    return map;
  }

  UserStatsCompanion toCompanion(bool nullToAbsent) {
    return UserStatsCompanion(
      id: Value(id),
      totalXP: Value(totalXP),
      level: Value(level),
      streakDays: Value(streakDays),
      lastPlayedDate: Value(lastPlayedDate),
      puzzlesPerDifficulty: Value(puzzlesPerDifficulty),
      bestTimesJson: Value(bestTimesJson),
      totalMistakes: Value(totalMistakes),
      totalHints: Value(totalHints),
    );
  }

  factory UserStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserStat(
      id: serializer.fromJson<int>(json['id']),
      totalXP: serializer.fromJson<int>(json['totalXP']),
      level: serializer.fromJson<int>(json['level']),
      streakDays: serializer.fromJson<int>(json['streakDays']),
      lastPlayedDate: serializer.fromJson<String>(json['lastPlayedDate']),
      puzzlesPerDifficulty: serializer.fromJson<String>(
        json['puzzlesPerDifficulty'],
      ),
      bestTimesJson: serializer.fromJson<String>(json['bestTimesJson']),
      totalMistakes: serializer.fromJson<int>(json['totalMistakes']),
      totalHints: serializer.fromJson<int>(json['totalHints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'totalXP': serializer.toJson<int>(totalXP),
      'level': serializer.toJson<int>(level),
      'streakDays': serializer.toJson<int>(streakDays),
      'lastPlayedDate': serializer.toJson<String>(lastPlayedDate),
      'puzzlesPerDifficulty': serializer.toJson<String>(puzzlesPerDifficulty),
      'bestTimesJson': serializer.toJson<String>(bestTimesJson),
      'totalMistakes': serializer.toJson<int>(totalMistakes),
      'totalHints': serializer.toJson<int>(totalHints),
    };
  }

  UserStat copyWith({
    int? id,
    int? totalXP,
    int? level,
    int? streakDays,
    String? lastPlayedDate,
    String? puzzlesPerDifficulty,
    String? bestTimesJson,
    int? totalMistakes,
    int? totalHints,
  }) => UserStat(
    id: id ?? this.id,
    totalXP: totalXP ?? this.totalXP,
    level: level ?? this.level,
    streakDays: streakDays ?? this.streakDays,
    lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
    puzzlesPerDifficulty: puzzlesPerDifficulty ?? this.puzzlesPerDifficulty,
    bestTimesJson: bestTimesJson ?? this.bestTimesJson,
    totalMistakes: totalMistakes ?? this.totalMistakes,
    totalHints: totalHints ?? this.totalHints,
  );
  UserStat copyWithCompanion(UserStatsCompanion data) {
    return UserStat(
      id: data.id.present ? data.id.value : this.id,
      totalXP: data.totalXP.present ? data.totalXP.value : this.totalXP,
      level: data.level.present ? data.level.value : this.level,
      streakDays: data.streakDays.present
          ? data.streakDays.value
          : this.streakDays,
      lastPlayedDate: data.lastPlayedDate.present
          ? data.lastPlayedDate.value
          : this.lastPlayedDate,
      puzzlesPerDifficulty: data.puzzlesPerDifficulty.present
          ? data.puzzlesPerDifficulty.value
          : this.puzzlesPerDifficulty,
      bestTimesJson: data.bestTimesJson.present
          ? data.bestTimesJson.value
          : this.bestTimesJson,
      totalMistakes: data.totalMistakes.present
          ? data.totalMistakes.value
          : this.totalMistakes,
      totalHints: data.totalHints.present
          ? data.totalHints.value
          : this.totalHints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserStat(')
          ..write('id: $id, ')
          ..write('totalXP: $totalXP, ')
          ..write('level: $level, ')
          ..write('streakDays: $streakDays, ')
          ..write('lastPlayedDate: $lastPlayedDate, ')
          ..write('puzzlesPerDifficulty: $puzzlesPerDifficulty, ')
          ..write('bestTimesJson: $bestTimesJson, ')
          ..write('totalMistakes: $totalMistakes, ')
          ..write('totalHints: $totalHints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    totalXP,
    level,
    streakDays,
    lastPlayedDate,
    puzzlesPerDifficulty,
    bestTimesJson,
    totalMistakes,
    totalHints,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserStat &&
          other.id == this.id &&
          other.totalXP == this.totalXP &&
          other.level == this.level &&
          other.streakDays == this.streakDays &&
          other.lastPlayedDate == this.lastPlayedDate &&
          other.puzzlesPerDifficulty == this.puzzlesPerDifficulty &&
          other.bestTimesJson == this.bestTimesJson &&
          other.totalMistakes == this.totalMistakes &&
          other.totalHints == this.totalHints);
}

class UserStatsCompanion extends UpdateCompanion<UserStat> {
  final Value<int> id;
  final Value<int> totalXP;
  final Value<int> level;
  final Value<int> streakDays;
  final Value<String> lastPlayedDate;
  final Value<String> puzzlesPerDifficulty;
  final Value<String> bestTimesJson;
  final Value<int> totalMistakes;
  final Value<int> totalHints;
  const UserStatsCompanion({
    this.id = const Value.absent(),
    this.totalXP = const Value.absent(),
    this.level = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.lastPlayedDate = const Value.absent(),
    this.puzzlesPerDifficulty = const Value.absent(),
    this.bestTimesJson = const Value.absent(),
    this.totalMistakes = const Value.absent(),
    this.totalHints = const Value.absent(),
  });
  UserStatsCompanion.insert({
    this.id = const Value.absent(),
    this.totalXP = const Value.absent(),
    this.level = const Value.absent(),
    this.streakDays = const Value.absent(),
    this.lastPlayedDate = const Value.absent(),
    this.puzzlesPerDifficulty = const Value.absent(),
    this.bestTimesJson = const Value.absent(),
    this.totalMistakes = const Value.absent(),
    this.totalHints = const Value.absent(),
  });
  static Insertable<UserStat> custom({
    Expression<int>? id,
    Expression<int>? totalXP,
    Expression<int>? level,
    Expression<int>? streakDays,
    Expression<String>? lastPlayedDate,
    Expression<String>? puzzlesPerDifficulty,
    Expression<String>? bestTimesJson,
    Expression<int>? totalMistakes,
    Expression<int>? totalHints,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalXP != null) 'total_x_p': totalXP,
      if (level != null) 'level': level,
      if (streakDays != null) 'streak_days': streakDays,
      if (lastPlayedDate != null) 'last_played_date': lastPlayedDate,
      if (puzzlesPerDifficulty != null)
        'puzzles_per_difficulty': puzzlesPerDifficulty,
      if (bestTimesJson != null) 'best_times_json': bestTimesJson,
      if (totalMistakes != null) 'total_mistakes': totalMistakes,
      if (totalHints != null) 'total_hints': totalHints,
    });
  }

  UserStatsCompanion copyWith({
    Value<int>? id,
    Value<int>? totalXP,
    Value<int>? level,
    Value<int>? streakDays,
    Value<String>? lastPlayedDate,
    Value<String>? puzzlesPerDifficulty,
    Value<String>? bestTimesJson,
    Value<int>? totalMistakes,
    Value<int>? totalHints,
  }) {
    return UserStatsCompanion(
      id: id ?? this.id,
      totalXP: totalXP ?? this.totalXP,
      level: level ?? this.level,
      streakDays: streakDays ?? this.streakDays,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      puzzlesPerDifficulty: puzzlesPerDifficulty ?? this.puzzlesPerDifficulty,
      bestTimesJson: bestTimesJson ?? this.bestTimesJson,
      totalMistakes: totalMistakes ?? this.totalMistakes,
      totalHints: totalHints ?? this.totalHints,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (totalXP.present) {
      map['total_x_p'] = Variable<int>(totalXP.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (streakDays.present) {
      map['streak_days'] = Variable<int>(streakDays.value);
    }
    if (lastPlayedDate.present) {
      map['last_played_date'] = Variable<String>(lastPlayedDate.value);
    }
    if (puzzlesPerDifficulty.present) {
      map['puzzles_per_difficulty'] = Variable<String>(
        puzzlesPerDifficulty.value,
      );
    }
    if (bestTimesJson.present) {
      map['best_times_json'] = Variable<String>(bestTimesJson.value);
    }
    if (totalMistakes.present) {
      map['total_mistakes'] = Variable<int>(totalMistakes.value);
    }
    if (totalHints.present) {
      map['total_hints'] = Variable<int>(totalHints.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserStatsCompanion(')
          ..write('id: $id, ')
          ..write('totalXP: $totalXP, ')
          ..write('level: $level, ')
          ..write('streakDays: $streakDays, ')
          ..write('lastPlayedDate: $lastPlayedDate, ')
          ..write('puzzlesPerDifficulty: $puzzlesPerDifficulty, ')
          ..write('bestTimesJson: $bestTimesJson, ')
          ..write('totalMistakes: $totalMistakes, ')
          ..write('totalHints: $totalHints')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<String> unlockedAt = GeneratedColumn<String>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    icon,
    unlockedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Achievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unlocked_at'],
      ),
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  /// e.g. "first_solve", "no_mistakes_easy".
  final String id;
  final String title;
  final String description;

  /// Icon identifier (e.g. Material icon name or asset path).
  final String icon;

  /// ISO 8601 unlock timestamp; null when locked.
  final String? unlockedAt;
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['icon'] = Variable<String>(icon);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<String>(unlockedAt);
    }
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      icon: Value(icon),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory Achievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      unlockedAt: serializer.fromJson<String?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String>(icon),
      'unlockedAt': serializer.toJson<String?>(unlockedAt),
    };
  }

  Achievement copyWith({
    String? id,
    String? title,
    String? description,
    String? icon,
    Value<String?> unlockedAt = const Value.absent(),
  }) => Achievement(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
  );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, icon, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> icon;
  final Value<String?> unlockedAt;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String icon,
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       icon = Value(icon);
  static Insertable<Achievement> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? icon,
    Value<String?>? unlockedAt,
    Value<int>? rowid,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<String>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyCompletionsTable extends DailyCompletions
    with TableInfo<$DailyCompletionsTable, DailyCompletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeSecondsMeta = const VerificationMeta(
    'timeSeconds',
  );
  @override
  late final GeneratedColumn<int> timeSeconds = GeneratedColumn<int>(
    'time_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mistakesMeta = const VerificationMeta(
    'mistakes',
  );
  @override
  late final GeneratedColumn<int> mistakes = GeneratedColumn<int>(
    'mistakes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hintsUsedMeta = const VerificationMeta(
    'hintsUsed',
  );
  @override
  late final GeneratedColumn<int> hintsUsed = GeneratedColumn<int>(
    'hints_used',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    date,
    difficulty,
    timeSeconds,
    mistakes,
    hintsUsed,
    xpEarned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyCompletion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('time_seconds')) {
      context.handle(
        _timeSecondsMeta,
        timeSeconds.isAcceptableOrUnknown(
          data['time_seconds']!,
          _timeSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeSecondsMeta);
    }
    if (data.containsKey('mistakes')) {
      context.handle(
        _mistakesMeta,
        mistakes.isAcceptableOrUnknown(data['mistakes']!, _mistakesMeta),
      );
    }
    if (data.containsKey('hints_used')) {
      context.handle(
        _hintsUsedMeta,
        hintsUsed.isAcceptableOrUnknown(data['hints_used']!, _hintsUsedMeta),
      );
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailyCompletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyCompletion(
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      timeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_seconds'],
      )!,
      mistakes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mistakes'],
      )!,
      hintsUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hints_used'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      )!,
    );
  }

  @override
  $DailyCompletionsTable createAlias(String alias) {
    return $DailyCompletionsTable(attachedDatabase, alias);
  }
}

class DailyCompletion extends DataClass implements Insertable<DailyCompletion> {
  /// ISO date string, e.g. "2024-03-10".
  final String date;
  final String difficulty;
  final int timeSeconds;
  final int mistakes;
  final int hintsUsed;
  final int xpEarned;
  const DailyCompletion({
    required this.date,
    required this.difficulty,
    required this.timeSeconds,
    required this.mistakes,
    required this.hintsUsed,
    required this.xpEarned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['difficulty'] = Variable<String>(difficulty);
    map['time_seconds'] = Variable<int>(timeSeconds);
    map['mistakes'] = Variable<int>(mistakes);
    map['hints_used'] = Variable<int>(hintsUsed);
    map['xp_earned'] = Variable<int>(xpEarned);
    return map;
  }

  DailyCompletionsCompanion toCompanion(bool nullToAbsent) {
    return DailyCompletionsCompanion(
      date: Value(date),
      difficulty: Value(difficulty),
      timeSeconds: Value(timeSeconds),
      mistakes: Value(mistakes),
      hintsUsed: Value(hintsUsed),
      xpEarned: Value(xpEarned),
    );
  }

  factory DailyCompletion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyCompletion(
      date: serializer.fromJson<String>(json['date']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      timeSeconds: serializer.fromJson<int>(json['timeSeconds']),
      mistakes: serializer.fromJson<int>(json['mistakes']),
      hintsUsed: serializer.fromJson<int>(json['hintsUsed']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'difficulty': serializer.toJson<String>(difficulty),
      'timeSeconds': serializer.toJson<int>(timeSeconds),
      'mistakes': serializer.toJson<int>(mistakes),
      'hintsUsed': serializer.toJson<int>(hintsUsed),
      'xpEarned': serializer.toJson<int>(xpEarned),
    };
  }

  DailyCompletion copyWith({
    String? date,
    String? difficulty,
    int? timeSeconds,
    int? mistakes,
    int? hintsUsed,
    int? xpEarned,
  }) => DailyCompletion(
    date: date ?? this.date,
    difficulty: difficulty ?? this.difficulty,
    timeSeconds: timeSeconds ?? this.timeSeconds,
    mistakes: mistakes ?? this.mistakes,
    hintsUsed: hintsUsed ?? this.hintsUsed,
    xpEarned: xpEarned ?? this.xpEarned,
  );
  DailyCompletion copyWithCompanion(DailyCompletionsCompanion data) {
    return DailyCompletion(
      date: data.date.present ? data.date.value : this.date,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      timeSeconds: data.timeSeconds.present
          ? data.timeSeconds.value
          : this.timeSeconds,
      mistakes: data.mistakes.present ? data.mistakes.value : this.mistakes,
      hintsUsed: data.hintsUsed.present ? data.hintsUsed.value : this.hintsUsed,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyCompletion(')
          ..write('date: $date, ')
          ..write('difficulty: $difficulty, ')
          ..write('timeSeconds: $timeSeconds, ')
          ..write('mistakes: $mistakes, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('xpEarned: $xpEarned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(date, difficulty, timeSeconds, mistakes, hintsUsed, xpEarned);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyCompletion &&
          other.date == this.date &&
          other.difficulty == this.difficulty &&
          other.timeSeconds == this.timeSeconds &&
          other.mistakes == this.mistakes &&
          other.hintsUsed == this.hintsUsed &&
          other.xpEarned == this.xpEarned);
}

class DailyCompletionsCompanion extends UpdateCompanion<DailyCompletion> {
  final Value<String> date;
  final Value<String> difficulty;
  final Value<int> timeSeconds;
  final Value<int> mistakes;
  final Value<int> hintsUsed;
  final Value<int> xpEarned;
  final Value<int> rowid;
  const DailyCompletionsCompanion({
    this.date = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.timeSeconds = const Value.absent(),
    this.mistakes = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyCompletionsCompanion.insert({
    required String date,
    required String difficulty,
    required int timeSeconds,
    this.mistakes = const Value.absent(),
    this.hintsUsed = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date),
       difficulty = Value(difficulty),
       timeSeconds = Value(timeSeconds);
  static Insertable<DailyCompletion> custom({
    Expression<String>? date,
    Expression<String>? difficulty,
    Expression<int>? timeSeconds,
    Expression<int>? mistakes,
    Expression<int>? hintsUsed,
    Expression<int>? xpEarned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (difficulty != null) 'difficulty': difficulty,
      if (timeSeconds != null) 'time_seconds': timeSeconds,
      if (mistakes != null) 'mistakes': mistakes,
      if (hintsUsed != null) 'hints_used': hintsUsed,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyCompletionsCompanion copyWith({
    Value<String>? date,
    Value<String>? difficulty,
    Value<int>? timeSeconds,
    Value<int>? mistakes,
    Value<int>? hintsUsed,
    Value<int>? xpEarned,
    Value<int>? rowid,
  }) {
    return DailyCompletionsCompanion(
      date: date ?? this.date,
      difficulty: difficulty ?? this.difficulty,
      timeSeconds: timeSeconds ?? this.timeSeconds,
      mistakes: mistakes ?? this.mistakes,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      xpEarned: xpEarned ?? this.xpEarned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (timeSeconds.present) {
      map['time_seconds'] = Variable<int>(timeSeconds.value);
    }
    if (mistakes.present) {
      map['mistakes'] = Variable<int>(mistakes.value);
    }
    if (hintsUsed.present) {
      map['hints_used'] = Variable<int>(hintsUsed.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyCompletionsCompanion(')
          ..write('date: $date, ')
          ..write('difficulty: $difficulty, ')
          ..write('timeSeconds: $timeSeconds, ')
          ..write('mistakes: $mistakes, ')
          ..write('hintsUsed: $hintsUsed, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventProgressTable extends EventProgress
    with TableInfo<$EventProgressTable, EventProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trophiesEarnedMeta = const VerificationMeta(
    'trophiesEarned',
  );
  @override
  late final GeneratedColumn<int> trophiesEarned = GeneratedColumn<int>(
    'trophies_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _puzzlesDoneMeta = const VerificationMeta(
    'puzzlesDone',
  );
  @override
  late final GeneratedColumn<int> puzzlesDone = GeneratedColumn<int>(
    'puzzles_done',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _claimedMilestonesJsonMeta =
      const VerificationMeta('claimedMilestonesJson');
  @override
  late final GeneratedColumn<String> claimedMilestonesJson =
      GeneratedColumn<String>(
        'claimed_milestones_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    eventId,
    trophiesEarned,
    puzzlesDone,
    claimedMilestonesJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('trophies_earned')) {
      context.handle(
        _trophiesEarnedMeta,
        trophiesEarned.isAcceptableOrUnknown(
          data['trophies_earned']!,
          _trophiesEarnedMeta,
        ),
      );
    }
    if (data.containsKey('puzzles_done')) {
      context.handle(
        _puzzlesDoneMeta,
        puzzlesDone.isAcceptableOrUnknown(
          data['puzzles_done']!,
          _puzzlesDoneMeta,
        ),
      );
    }
    if (data.containsKey('claimed_milestones_json')) {
      context.handle(
        _claimedMilestonesJsonMeta,
        claimedMilestonesJson.isAcceptableOrUnknown(
          data['claimed_milestones_json']!,
          _claimedMilestonesJsonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId};
  @override
  EventProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventProgressData(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      trophiesEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trophies_earned'],
      )!,
      puzzlesDone: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}puzzles_done'],
      )!,
      claimedMilestonesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}claimed_milestones_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EventProgressTable createAlias(String alias) {
    return $EventProgressTable(attachedDatabase, alias);
  }
}

class EventProgressData extends DataClass
    implements Insertable<EventProgressData> {
  final String eventId;
  final int trophiesEarned;
  final int puzzlesDone;
  final String claimedMilestonesJson;
  final String updatedAt;
  const EventProgressData({
    required this.eventId,
    required this.trophiesEarned,
    required this.puzzlesDone,
    required this.claimedMilestonesJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['trophies_earned'] = Variable<int>(trophiesEarned);
    map['puzzles_done'] = Variable<int>(puzzlesDone);
    map['claimed_milestones_json'] = Variable<String>(claimedMilestonesJson);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  EventProgressCompanion toCompanion(bool nullToAbsent) {
    return EventProgressCompanion(
      eventId: Value(eventId),
      trophiesEarned: Value(trophiesEarned),
      puzzlesDone: Value(puzzlesDone),
      claimedMilestonesJson: Value(claimedMilestonesJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory EventProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventProgressData(
      eventId: serializer.fromJson<String>(json['eventId']),
      trophiesEarned: serializer.fromJson<int>(json['trophiesEarned']),
      puzzlesDone: serializer.fromJson<int>(json['puzzlesDone']),
      claimedMilestonesJson: serializer.fromJson<String>(
        json['claimedMilestonesJson'],
      ),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'trophiesEarned': serializer.toJson<int>(trophiesEarned),
      'puzzlesDone': serializer.toJson<int>(puzzlesDone),
      'claimedMilestonesJson': serializer.toJson<String>(claimedMilestonesJson),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  EventProgressData copyWith({
    String? eventId,
    int? trophiesEarned,
    int? puzzlesDone,
    String? claimedMilestonesJson,
    String? updatedAt,
  }) => EventProgressData(
    eventId: eventId ?? this.eventId,
    trophiesEarned: trophiesEarned ?? this.trophiesEarned,
    puzzlesDone: puzzlesDone ?? this.puzzlesDone,
    claimedMilestonesJson: claimedMilestonesJson ?? this.claimedMilestonesJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EventProgressData copyWithCompanion(EventProgressCompanion data) {
    return EventProgressData(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      trophiesEarned: data.trophiesEarned.present
          ? data.trophiesEarned.value
          : this.trophiesEarned,
      puzzlesDone: data.puzzlesDone.present
          ? data.puzzlesDone.value
          : this.puzzlesDone,
      claimedMilestonesJson: data.claimedMilestonesJson.present
          ? data.claimedMilestonesJson.value
          : this.claimedMilestonesJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventProgressData(')
          ..write('eventId: $eventId, ')
          ..write('trophiesEarned: $trophiesEarned, ')
          ..write('puzzlesDone: $puzzlesDone, ')
          ..write('claimedMilestonesJson: $claimedMilestonesJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    eventId,
    trophiesEarned,
    puzzlesDone,
    claimedMilestonesJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventProgressData &&
          other.eventId == this.eventId &&
          other.trophiesEarned == this.trophiesEarned &&
          other.puzzlesDone == this.puzzlesDone &&
          other.claimedMilestonesJson == this.claimedMilestonesJson &&
          other.updatedAt == this.updatedAt);
}

class EventProgressCompanion extends UpdateCompanion<EventProgressData> {
  final Value<String> eventId;
  final Value<int> trophiesEarned;
  final Value<int> puzzlesDone;
  final Value<String> claimedMilestonesJson;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const EventProgressCompanion({
    this.eventId = const Value.absent(),
    this.trophiesEarned = const Value.absent(),
    this.puzzlesDone = const Value.absent(),
    this.claimedMilestonesJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventProgressCompanion.insert({
    required String eventId,
    this.trophiesEarned = const Value.absent(),
    this.puzzlesDone = const Value.absent(),
    this.claimedMilestonesJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId);
  static Insertable<EventProgressData> custom({
    Expression<String>? eventId,
    Expression<int>? trophiesEarned,
    Expression<int>? puzzlesDone,
    Expression<String>? claimedMilestonesJson,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (trophiesEarned != null) 'trophies_earned': trophiesEarned,
      if (puzzlesDone != null) 'puzzles_done': puzzlesDone,
      if (claimedMilestonesJson != null)
        'claimed_milestones_json': claimedMilestonesJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventProgressCompanion copyWith({
    Value<String>? eventId,
    Value<int>? trophiesEarned,
    Value<int>? puzzlesDone,
    Value<String>? claimedMilestonesJson,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return EventProgressCompanion(
      eventId: eventId ?? this.eventId,
      trophiesEarned: trophiesEarned ?? this.trophiesEarned,
      puzzlesDone: puzzlesDone ?? this.puzzlesDone,
      claimedMilestonesJson:
          claimedMilestonesJson ?? this.claimedMilestonesJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (trophiesEarned.present) {
      map['trophies_earned'] = Variable<int>(trophiesEarned.value);
    }
    if (puzzlesDone.present) {
      map['puzzles_done'] = Variable<int>(puzzlesDone.value);
    }
    if (claimedMilestonesJson.present) {
      map['claimed_milestones_json'] = Variable<String>(
        claimedMilestonesJson.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventProgressCompanion(')
          ..write('eventId: $eventId, ')
          ..write('trophiesEarned: $trophiesEarned, ')
          ..write('puzzlesDone: $puzzlesDone, ')
          ..write('claimedMilestonesJson: $claimedMilestonesJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SavedGamesTable savedGames = $SavedGamesTable(this);
  late final $UserStatsTable userStats = $UserStatsTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $DailyCompletionsTable dailyCompletions = $DailyCompletionsTable(
    this,
  );
  late final $EventProgressTable eventProgress = $EventProgressTable(this);
  late final SavedGamesDao savedGamesDao = SavedGamesDao(this as AppDatabase);
  late final UserStatsDao userStatsDao = UserStatsDao(this as AppDatabase);
  late final AchievementsDao achievementsDao = AchievementsDao(
    this as AppDatabase,
  );
  late final DailyDao dailyDao = DailyDao(this as AppDatabase);
  late final EventDao eventDao = EventDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    savedGames,
    userStats,
    achievements,
    dailyCompletions,
    eventProgress,
  ];
}

typedef $$SavedGamesTableCreateCompanionBuilder =
    SavedGamesCompanion Function({
      Value<int> id,
      required String puzzle,
      required String userGrid,
      required String solution,
      required String difficulty,
      Value<int> elapsedSeconds,
      Value<int> hintsUsed,
      Value<int> mistakes,
      Value<String> notesJson,
      required String createdAt,
      required String updatedAt,
    });
typedef $$SavedGamesTableUpdateCompanionBuilder =
    SavedGamesCompanion Function({
      Value<int> id,
      Value<String> puzzle,
      Value<String> userGrid,
      Value<String> solution,
      Value<String> difficulty,
      Value<int> elapsedSeconds,
      Value<int> hintsUsed,
      Value<int> mistakes,
      Value<String> notesJson,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

class $$SavedGamesTableFilterComposer
    extends Composer<_$AppDatabase, $SavedGamesTable> {
  $$SavedGamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzle => $composableBuilder(
    column: $table.puzzle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userGrid => $composableBuilder(
    column: $table.userGrid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get solution => $composableBuilder(
    column: $table.solution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notesJson => $composableBuilder(
    column: $table.notesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedGamesTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedGamesTable> {
  $$SavedGamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzle => $composableBuilder(
    column: $table.puzzle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userGrid => $composableBuilder(
    column: $table.userGrid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solution => $composableBuilder(
    column: $table.solution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notesJson => $composableBuilder(
    column: $table.notesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedGamesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedGamesTable> {
  $$SavedGamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get puzzle =>
      $composableBuilder(column: $table.puzzle, builder: (column) => column);

  GeneratedColumn<String> get userGrid =>
      $composableBuilder(column: $table.userGrid, builder: (column) => column);

  GeneratedColumn<String> get solution =>
      $composableBuilder(column: $table.solution, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hintsUsed =>
      $composableBuilder(column: $table.hintsUsed, builder: (column) => column);

  GeneratedColumn<int> get mistakes =>
      $composableBuilder(column: $table.mistakes, builder: (column) => column);

  GeneratedColumn<String> get notesJson =>
      $composableBuilder(column: $table.notesJson, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SavedGamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedGamesTable,
          SavedGame,
          $$SavedGamesTableFilterComposer,
          $$SavedGamesTableOrderingComposer,
          $$SavedGamesTableAnnotationComposer,
          $$SavedGamesTableCreateCompanionBuilder,
          $$SavedGamesTableUpdateCompanionBuilder,
          (
            SavedGame,
            BaseReferences<_$AppDatabase, $SavedGamesTable, SavedGame>,
          ),
          SavedGame,
          PrefetchHooks Function()
        > {
  $$SavedGamesTableTableManager(_$AppDatabase db, $SavedGamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedGamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedGamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedGamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> puzzle = const Value.absent(),
                Value<String> userGrid = const Value.absent(),
                Value<String> solution = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<int> hintsUsed = const Value.absent(),
                Value<int> mistakes = const Value.absent(),
                Value<String> notesJson = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => SavedGamesCompanion(
                id: id,
                puzzle: puzzle,
                userGrid: userGrid,
                solution: solution,
                difficulty: difficulty,
                elapsedSeconds: elapsedSeconds,
                hintsUsed: hintsUsed,
                mistakes: mistakes,
                notesJson: notesJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String puzzle,
                required String userGrid,
                required String solution,
                required String difficulty,
                Value<int> elapsedSeconds = const Value.absent(),
                Value<int> hintsUsed = const Value.absent(),
                Value<int> mistakes = const Value.absent(),
                Value<String> notesJson = const Value.absent(),
                required String createdAt,
                required String updatedAt,
              }) => SavedGamesCompanion.insert(
                id: id,
                puzzle: puzzle,
                userGrid: userGrid,
                solution: solution,
                difficulty: difficulty,
                elapsedSeconds: elapsedSeconds,
                hintsUsed: hintsUsed,
                mistakes: mistakes,
                notesJson: notesJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedGamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedGamesTable,
      SavedGame,
      $$SavedGamesTableFilterComposer,
      $$SavedGamesTableOrderingComposer,
      $$SavedGamesTableAnnotationComposer,
      $$SavedGamesTableCreateCompanionBuilder,
      $$SavedGamesTableUpdateCompanionBuilder,
      (SavedGame, BaseReferences<_$AppDatabase, $SavedGamesTable, SavedGame>),
      SavedGame,
      PrefetchHooks Function()
    >;
typedef $$UserStatsTableCreateCompanionBuilder =
    UserStatsCompanion Function({
      Value<int> id,
      Value<int> totalXP,
      Value<int> level,
      Value<int> streakDays,
      Value<String> lastPlayedDate,
      Value<String> puzzlesPerDifficulty,
      Value<String> bestTimesJson,
      Value<int> totalMistakes,
      Value<int> totalHints,
    });
typedef $$UserStatsTableUpdateCompanionBuilder =
    UserStatsCompanion Function({
      Value<int> id,
      Value<int> totalXP,
      Value<int> level,
      Value<int> streakDays,
      Value<String> lastPlayedDate,
      Value<String> puzzlesPerDifficulty,
      Value<String> bestTimesJson,
      Value<int> totalMistakes,
      Value<int> totalHints,
    });

class $$UserStatsTableFilterComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalXP => $composableBuilder(
    column: $table.totalXP,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastPlayedDate => $composableBuilder(
    column: $table.lastPlayedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzlesPerDifficulty => $composableBuilder(
    column: $table.puzzlesPerDifficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bestTimesJson => $composableBuilder(
    column: $table.bestTimesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalMistakes => $composableBuilder(
    column: $table.totalMistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalHints => $composableBuilder(
    column: $table.totalHints,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalXP => $composableBuilder(
    column: $table.totalXP,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastPlayedDate => $composableBuilder(
    column: $table.lastPlayedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzlesPerDifficulty => $composableBuilder(
    column: $table.puzzlesPerDifficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bestTimesJson => $composableBuilder(
    column: $table.bestTimesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalMistakes => $composableBuilder(
    column: $table.totalMistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalHints => $composableBuilder(
    column: $table.totalHints,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserStatsTable> {
  $$UserStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalXP =>
      $composableBuilder(column: $table.totalXP, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get streakDays => $composableBuilder(
    column: $table.streakDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastPlayedDate => $composableBuilder(
    column: $table.lastPlayedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get puzzlesPerDifficulty => $composableBuilder(
    column: $table.puzzlesPerDifficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bestTimesJson => $composableBuilder(
    column: $table.bestTimesJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalMistakes => $composableBuilder(
    column: $table.totalMistakes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalHints => $composableBuilder(
    column: $table.totalHints,
    builder: (column) => column,
  );
}

class $$UserStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserStatsTable,
          UserStat,
          $$UserStatsTableFilterComposer,
          $$UserStatsTableOrderingComposer,
          $$UserStatsTableAnnotationComposer,
          $$UserStatsTableCreateCompanionBuilder,
          $$UserStatsTableUpdateCompanionBuilder,
          (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
          UserStat,
          PrefetchHooks Function()
        > {
  $$UserStatsTableTableManager(_$AppDatabase db, $UserStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXP = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<String> lastPlayedDate = const Value.absent(),
                Value<String> puzzlesPerDifficulty = const Value.absent(),
                Value<String> bestTimesJson = const Value.absent(),
                Value<int> totalMistakes = const Value.absent(),
                Value<int> totalHints = const Value.absent(),
              }) => UserStatsCompanion(
                id: id,
                totalXP: totalXP,
                level: level,
                streakDays: streakDays,
                lastPlayedDate: lastPlayedDate,
                puzzlesPerDifficulty: puzzlesPerDifficulty,
                bestTimesJson: bestTimesJson,
                totalMistakes: totalMistakes,
                totalHints: totalHints,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> totalXP = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> streakDays = const Value.absent(),
                Value<String> lastPlayedDate = const Value.absent(),
                Value<String> puzzlesPerDifficulty = const Value.absent(),
                Value<String> bestTimesJson = const Value.absent(),
                Value<int> totalMistakes = const Value.absent(),
                Value<int> totalHints = const Value.absent(),
              }) => UserStatsCompanion.insert(
                id: id,
                totalXP: totalXP,
                level: level,
                streakDays: streakDays,
                lastPlayedDate: lastPlayedDate,
                puzzlesPerDifficulty: puzzlesPerDifficulty,
                bestTimesJson: bestTimesJson,
                totalMistakes: totalMistakes,
                totalHints: totalHints,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserStatsTable,
      UserStat,
      $$UserStatsTableFilterComposer,
      $$UserStatsTableOrderingComposer,
      $$UserStatsTableAnnotationComposer,
      $$UserStatsTableCreateCompanionBuilder,
      $$UserStatsTableUpdateCompanionBuilder,
      (UserStat, BaseReferences<_$AppDatabase, $UserStatsTable, UserStat>),
      UserStat,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      required String id,
      required String title,
      required String description,
      required String icon,
      Value<String?> unlockedAt,
      Value<int> rowid,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<String> icon,
      Value<String?> unlockedAt,
      Value<int> rowid,
    });

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          Achievement,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (
            Achievement,
            BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
          ),
          Achievement,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                title: title,
                description: description,
                icon: icon,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required String icon,
                Value<String?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion.insert(
                id: id,
                title: title,
                description: description,
                icon: icon,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      Achievement,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (
        Achievement,
        BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
      ),
      Achievement,
      PrefetchHooks Function()
    >;
typedef $$DailyCompletionsTableCreateCompanionBuilder =
    DailyCompletionsCompanion Function({
      required String date,
      required String difficulty,
      required int timeSeconds,
      Value<int> mistakes,
      Value<int> hintsUsed,
      Value<int> xpEarned,
      Value<int> rowid,
    });
typedef $$DailyCompletionsTableUpdateCompanionBuilder =
    DailyCompletionsCompanion Function({
      Value<String> date,
      Value<String> difficulty,
      Value<int> timeSeconds,
      Value<int> mistakes,
      Value<int> hintsUsed,
      Value<int> xpEarned,
      Value<int> rowid,
    });

class $$DailyCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyCompletionsTable> {
  $$DailyCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeSeconds => $composableBuilder(
    column: $table.timeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyCompletionsTable> {
  $$DailyCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeSeconds => $composableBuilder(
    column: $table.timeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mistakes => $composableBuilder(
    column: $table.mistakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hintsUsed => $composableBuilder(
    column: $table.hintsUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyCompletionsTable> {
  $$DailyCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeSeconds => $composableBuilder(
    column: $table.timeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mistakes =>
      $composableBuilder(column: $table.mistakes, builder: (column) => column);

  GeneratedColumn<int> get hintsUsed =>
      $composableBuilder(column: $table.hintsUsed, builder: (column) => column);

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);
}

class $$DailyCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyCompletionsTable,
          DailyCompletion,
          $$DailyCompletionsTableFilterComposer,
          $$DailyCompletionsTableOrderingComposer,
          $$DailyCompletionsTableAnnotationComposer,
          $$DailyCompletionsTableCreateCompanionBuilder,
          $$DailyCompletionsTableUpdateCompanionBuilder,
          (
            DailyCompletion,
            BaseReferences<
              _$AppDatabase,
              $DailyCompletionsTable,
              DailyCompletion
            >,
          ),
          DailyCompletion,
          PrefetchHooks Function()
        > {
  $$DailyCompletionsTableTableManager(
    _$AppDatabase db,
    $DailyCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> date = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<int> timeSeconds = const Value.absent(),
                Value<int> mistakes = const Value.absent(),
                Value<int> hintsUsed = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCompletionsCompanion(
                date: date,
                difficulty: difficulty,
                timeSeconds: timeSeconds,
                mistakes: mistakes,
                hintsUsed: hintsUsed,
                xpEarned: xpEarned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String date,
                required String difficulty,
                required int timeSeconds,
                Value<int> mistakes = const Value.absent(),
                Value<int> hintsUsed = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyCompletionsCompanion.insert(
                date: date,
                difficulty: difficulty,
                timeSeconds: timeSeconds,
                mistakes: mistakes,
                hintsUsed: hintsUsed,
                xpEarned: xpEarned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyCompletionsTable,
      DailyCompletion,
      $$DailyCompletionsTableFilterComposer,
      $$DailyCompletionsTableOrderingComposer,
      $$DailyCompletionsTableAnnotationComposer,
      $$DailyCompletionsTableCreateCompanionBuilder,
      $$DailyCompletionsTableUpdateCompanionBuilder,
      (
        DailyCompletion,
        BaseReferences<_$AppDatabase, $DailyCompletionsTable, DailyCompletion>,
      ),
      DailyCompletion,
      PrefetchHooks Function()
    >;
typedef $$EventProgressTableCreateCompanionBuilder =
    EventProgressCompanion Function({
      required String eventId,
      Value<int> trophiesEarned,
      Value<int> puzzlesDone,
      Value<String> claimedMilestonesJson,
      Value<String> updatedAt,
      Value<int> rowid,
    });
typedef $$EventProgressTableUpdateCompanionBuilder =
    EventProgressCompanion Function({
      Value<String> eventId,
      Value<int> trophiesEarned,
      Value<int> puzzlesDone,
      Value<String> claimedMilestonesJson,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $$EventProgressTableFilterComposer
    extends Composer<_$AppDatabase, $EventProgressTable> {
  $$EventProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trophiesEarned => $composableBuilder(
    column: $table.trophiesEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get puzzlesDone => $composableBuilder(
    column: $table.puzzlesDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get claimedMilestonesJson => $composableBuilder(
    column: $table.claimedMilestonesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $EventProgressTable> {
  $$EventProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trophiesEarned => $composableBuilder(
    column: $table.trophiesEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get puzzlesDone => $composableBuilder(
    column: $table.puzzlesDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get claimedMilestonesJson => $composableBuilder(
    column: $table.claimedMilestonesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventProgressTable> {
  $$EventProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<int> get trophiesEarned => $composableBuilder(
    column: $table.trophiesEarned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get puzzlesDone => $composableBuilder(
    column: $table.puzzlesDone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get claimedMilestonesJson => $composableBuilder(
    column: $table.claimedMilestonesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EventProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventProgressTable,
          EventProgressData,
          $$EventProgressTableFilterComposer,
          $$EventProgressTableOrderingComposer,
          $$EventProgressTableAnnotationComposer,
          $$EventProgressTableCreateCompanionBuilder,
          $$EventProgressTableUpdateCompanionBuilder,
          (
            EventProgressData,
            BaseReferences<
              _$AppDatabase,
              $EventProgressTable,
              EventProgressData
            >,
          ),
          EventProgressData,
          PrefetchHooks Function()
        > {
  $$EventProgressTableTableManager(_$AppDatabase db, $EventProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<int> trophiesEarned = const Value.absent(),
                Value<int> puzzlesDone = const Value.absent(),
                Value<String> claimedMilestonesJson = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventProgressCompanion(
                eventId: eventId,
                trophiesEarned: trophiesEarned,
                puzzlesDone: puzzlesDone,
                claimedMilestonesJson: claimedMilestonesJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                Value<int> trophiesEarned = const Value.absent(),
                Value<int> puzzlesDone = const Value.absent(),
                Value<String> claimedMilestonesJson = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventProgressCompanion.insert(
                eventId: eventId,
                trophiesEarned: trophiesEarned,
                puzzlesDone: puzzlesDone,
                claimedMilestonesJson: claimedMilestonesJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventProgressTable,
      EventProgressData,
      $$EventProgressTableFilterComposer,
      $$EventProgressTableOrderingComposer,
      $$EventProgressTableAnnotationComposer,
      $$EventProgressTableCreateCompanionBuilder,
      $$EventProgressTableUpdateCompanionBuilder,
      (
        EventProgressData,
        BaseReferences<_$AppDatabase, $EventProgressTable, EventProgressData>,
      ),
      EventProgressData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SavedGamesTableTableManager get savedGames =>
      $$SavedGamesTableTableManager(_db, _db.savedGames);
  $$UserStatsTableTableManager get userStats =>
      $$UserStatsTableTableManager(_db, _db.userStats);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$DailyCompletionsTableTableManager get dailyCompletions =>
      $$DailyCompletionsTableTableManager(_db, _db.dailyCompletions);
  $$EventProgressTableTableManager get eventProgress =>
      $$EventProgressTableTableManager(_db, _db.eventProgress);
}
