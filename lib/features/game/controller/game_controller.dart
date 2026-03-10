// lib/features/game/controller/game_controller.dart

import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/db/app_database.dart';
import '../../../core/db/db_service.dart';
import '../../../core/puzzle/models.dart';
import '../../../core/puzzle/sudoku_generator.dart';
import '../../../core/puzzle/sudoku_validator.dart';
import '../../daily/daily_controller.dart';
import '../../events/event_controller.dart';
import '../../../core/firebase/firestore_service.dart';
import '../../gamification/xp_service.dart';
import '../../gamification/achievement_service.dart';
import '../../../core/ads/ad_service.dart';
import '../../home/home_controller.dart';

 // Removed hardcoded XP constants 

class GameController extends GetxController with WidgetsBindingObserver {
  // ── Observables ──────────────────────────────────────────────────────────

  /// The original puzzle grid (given cells).
  final puzzle = RxList<List<int>>.generate(9, (_) => List.filled(9, 0));

  /// The user-editable grid (starts as copy of puzzle).
  final userGrid = RxList<List<int>>.generate(9, (_) => List.filled(9, 0));

  /// The authoritative solution grid.
  final solution = RxList<List<int>>.generate(9, (_) => List.filled(9, 0));

  final selectedRow = RxInt(-1);
  final selectedCol = RxInt(-1);

  /// Indexes of cells highlighted because they share row/col/box with selection.
  final highlightedCells = RxSet<String>();

  /// Indexes of cells that share the same number as the selected cell.
  final sameNumberCells = RxSet<String>();

  /// Cells with an error state — key 'r,c'.
  final errorCells = RxSet<String>();

  /// Pencil-mark notes. Key = 'r,c', value = set of candidate digits.
  final cellNotes = RxMap<String, Set<int>>();

  final hintsRemaining = RxInt(1);
  final mistakesCount = RxInt(0);
  final elapsedSeconds = RxInt(0);

  final isPaused = RxBool(false);
  final isComplete = RxBool(false);
  final isGameOver = RxBool(false);
  final notesMode = RxBool(false);
  final hasUsedAdLife = RxBool(false);
  
  bool isDaily = false;

  final difficulty = Rx<Difficulty>(Difficulty.easy);

  // ── Private state ────────────────────────────────────────────────────────

  Timer? _timer;
  int? _savedGameId; // Drift row id for the current save-slot
  int _hintsUsed = 0;
  late SudokuPuzzle _currentPuzzle;

  // ── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    
    final Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      isDaily = args['isDaily'] ?? false;
      
      final action = args['action'];
      if (action == 'new') {
        startGame(args['difficulty']);
      } else if (action == 'resume') {
        resumeSavedGame(args['savedGame']);
      } else if (action == 'daily') {
        startDailyGame(args['date']);
      } else if (action == 'daily_puzzle') {
        _applyPuzzle(args['puzzle']);
      }
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      autoSave();
    }
  }

  // ── Public API ────────────────────────────────────────────────────────────

  /// Generates a new puzzle and resets all state.
  void startGame(Difficulty d) {
    _currentPuzzle = SudokuGenerator.generate(d);
    _applyPuzzle(_currentPuzzle);
  }

  /// Starts a daily-challenge puzzle for [dateStr] (e.g. '2024-03-10').
  void startDailyGame(String dateStr) {
    _currentPuzzle = SudokuGenerator.generateForDate(dateStr);
    _applyPuzzle(_currentPuzzle);
  }

  /// Restores a previously saved game from a Drift [SavedGame] record.
  void resumeSavedGame(SavedGame saved) {
    difficulty.value = Difficulty.values.firstWhere(
      (d) => d.name == saved.difficulty,
      orElse: () => Difficulty.easy,
    );

    final p = _decode2D(saved.puzzle);
    final u = _decode2D(saved.userGrid);
    final s = _decode2D(saved.solution);

    puzzle.assignAll(p);
    userGrid.assignAll(u);
    solution.assignAll(s);

    elapsedSeconds.value = saved.elapsedSeconds;
    hintsRemaining.value = 1; // restored sessions keep default
    _hintsUsed = saved.hintsUsed;
    mistakesCount.value = saved.mistakes;

    final notesRaw = jsonDecode(saved.notesJson) as Map<String, dynamic>;
    cellNotes.assignAll({
      for (final e in notesRaw.entries)
        e.key: Set<int>.from((e.value as List).cast<int>()),
    });

    _savedGameId = saved.id;

    _currentPuzzle = SudokuPuzzle(
      id: saved.id.toString(),
      puzzle: p,
      solution: s,
      difficulty: difficulty.value,
      createdAt: DateTime.parse(saved.createdAt),
    );

    _resetSelection();
    _startTimer();
  }

  /// Updates the selection and recomputes highlighted / same-number cells.
  void selectCell(int row, int col) {
    if (isComplete.value || isGameOver.value || isPaused.value) return;

    selectedRow.value = row;
    selectedCol.value = col;

    // Related cells (same row / col / box).
    final related = SudokuValidator.getRelatedCells(row, col);
    highlightedCells
      ..clear()
      ..addAll(related.map((rc) => '${rc.$1},${rc.$2}'));

    // Cells with same number.
    final val = userGrid[row][col];
    sameNumberCells.clear();
    if (val != 0) {
      for (var r = 0; r < 9; r++) {
        for (var c = 0; c < 9; c++) {
          if (userGrid[r][c] == val) sameNumberCells.add('$r,$c');
        }
      }
    }
  }

  /// Places a digit or toggles a note for the selected cell.
  void placeNumber(int n) {
    final row = selectedRow.value;
    final col = selectedCol.value;
    if (row == -1 || col == -1) return;
    if (isComplete.value || isGameOver.value || isPaused.value) return;

    if (notesMode.value) {
      _addNote(row, col, n);
      return;
    }

    // Given cells are locked.
    if (puzzle[row][col] != 0) return;

    if (n == solution[row][col]) {
      // Correct placement.
      errorCells.remove('$row,$col');

      final updated = List<List<int>>.from(userGrid.map(List<int>.of));
      updated[row][col] = n;
      userGrid.assignAll(updated);

      // Auto-remove notes that are now invalid in related cells.
      _clearRelatedNotes(row, col, n);

      // Refresh same-number highlight.
      selectCell(row, col);

      // Check for completion.
      if (_isBoardFull()) _onGameComplete();
    } else {
      // Wrong placement.
      errorCells.add('$row,$col');
      mistakesCount.value++;
      if (mistakesCount.value >= 3) {
        isGameOver.value = true;
        _timer?.cancel();
      }
    }
    autoSave();
  }

  /// Reveals the correct value for the currently selected empty cell.
  void useHint() {
    final row = selectedRow.value;
    final col = selectedCol.value;
    if (row == -1 || col == -1) return;
    if (isComplete.value || isGameOver.value || isPaused.value) return;
    if (puzzle[row][col] != 0) return; // already given
    if (userGrid[row][col] == solution[row][col]) return; // already correct

    if (hintsRemaining.value > 0) {
      hintsRemaining.value--;
      _hintsUsed++;
      placeNumber(solution[row][col]);
    } else {
      // Request ad from AdService
      AdService.to.showRewardedForHint(
        onRewarded: onRewardedHintEarned,
        onClosed: () {
          // Additional logic if needed on modal close
        },
      );
    }
  }

  /// Called by the ad SDK after a successful rewarded hint ad.
  void onRewardedHintEarned() {
    hintsRemaining.value++;
    useHint();
  }

  /// Called by the ad SDK after a successful rewarded extra-life ad.
  void onRewardedLifeEarned() {
    if (hasUsedAdLife.value) return;
    mistakesCount.value = 2; // one mistake slot left
    hasUsedAdLife.value = true;
    isGameOver.value = false;
    _startTimer();
  }

  void toggleNotes() => notesMode.toggle();

  /// Clears the value and notes from the selected cell (if it is not a given).
  void eraseCell() {
    final row = selectedRow.value;
    final col = selectedCol.value;
    if (row == -1 || col == -1) return;
    if (puzzle[row][col] != 0) return; // can't erase givens

    final updated = List<List<int>>.from(userGrid.map(List<int>.of));
    updated[row][col] = 0;
    userGrid.assignAll(updated);

    errorCells.remove('$row,$col');
    cellNotes.remove('$row,$col');
    selectCell(row, col);
    autoSave();
  }

  void pauseGame() {
    if (isComplete.value || isGameOver.value) return;
    isPaused.value = true;
    _timer?.cancel();
    autoSave();
  }

  void resumeGame() {
    if (!isPaused.value) return;
    isPaused.value = false;
    _startTimer();
  }

  /// Serialises the current game state to Drift (insert or update).
  Future<void> autoSave() async {
    if (isComplete.value) return;
    try {
      final db = DbService.instance;
      final now = DateTime.now().toIso8601String();
      final notesEncoded = jsonEncode({
        for (final e in cellNotes.entries)
          e.key: e.value.toList()..sort(),
      });

      final companion = SavedGamesCompanion(
        puzzle: drift.Value(jsonEncode(puzzle)),
        userGrid: drift.Value(jsonEncode(userGrid)),
        solution: drift.Value(jsonEncode(solution)),
        difficulty: drift.Value(difficulty.value.name),
        elapsedSeconds: drift.Value(elapsedSeconds.value),
        hintsUsed: drift.Value(_hintsUsed),
        mistakes: drift.Value(mistakesCount.value),
        notesJson: drift.Value(notesEncoded),
        updatedAt: drift.Value(now),
        createdAt: drift.Value(_savedGameId == null ? now : now),
      );

      if (_savedGameId == null) {
        _savedGameId = await db.savedGames.insertGame(companion);
      } else {
        await db.savedGames.updateGame(
          companion.copyWith(id: drift.Value(_savedGameId!)),
        );
      }
    } catch (_) {
      // Silently ignore – autosave is best-effort
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  void _applyPuzzle(SudokuPuzzle p) {
    _currentPuzzle = p;
    difficulty.value = p.difficulty;

    puzzle.assignAll(_deepCopy(p.puzzle));
    userGrid.assignAll(_deepCopy(p.puzzle));
    solution.assignAll(_deepCopy(p.solution));

    elapsedSeconds.value = 0;
    mistakesCount.value = 0;
    hintsRemaining.value = 1;
    _hintsUsed = 0;
    isComplete.value = false;
    isGameOver.value = false;
    isPaused.value = false;
    notesMode.value = false;
    hasUsedAdLife.value = false;
    cellNotes.clear();
    errorCells.clear();
    _savedGameId = null;
    _resetSelection();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isPaused.value && !isComplete.value && !isGameOver.value) {
        elapsedSeconds.value++;
        // Auto-save every 30 s.
        if (elapsedSeconds.value % 30 == 0) autoSave();
      }
    });
  }

  void _resetSelection() {
    selectedRow.value = -1;
    selectedCol.value = -1;
    highlightedCells.clear();
    sameNumberCells.clear();
  }

  void _addNote(int row, int col, int n) {
    if (puzzle[row][col] != 0) return;
    if (userGrid[row][col] != 0) return; // can't add notes to filled cell
    final key = '$row,$col';
    final current = Set<int>.from(cellNotes[key] ?? {});
    if (current.contains(n)) {
      current.remove(n);
    } else {
      current.add(n);
    }
    cellNotes[key] = current;
  }

  void _clearRelatedNotes(int row, int col, int n) {
    final related = SudokuValidator.getRelatedCells(row, col);
    for (final (r, c) in related) {
      final key = '$r,$c';
      if (cellNotes.containsKey(key)) {
        final updated = Set<int>.from(cellNotes[key]!)..remove(n);
        if (updated.isEmpty) {
          cellNotes.remove(key);
        } else {
          cellNotes[key] = updated;
        }
      }
    }
  }

  bool _isBoardFull() {
    for (var r = 0; r < 9; r++) {
      for (var c = 0; c < 9; c++) {
        if (userGrid[r][c] != solution[r][c]) return false;
      }
    }
    return true;
  }

  Future<void> _onGameComplete() async {
    _timer?.cancel();
    isComplete.value = true;

    final result = GameResult(
      puzzle: _currentPuzzle,
      elapsed: Duration(seconds: elapsedSeconds.value),
      mistakes: mistakesCount.value,
      hintsUsed: _hintsUsed,
      xpEarned: 0, // Calculated below
      difficulty: difficulty.value,
    );

    final xp = XpService.calculateXP(
      difficulty: result.difficulty,
      elapsedSeconds: result.elapsed.inSeconds,
      mistakes: result.mistakes,
      hintsUsed: result.hintsUsed,
      isDaily: isDaily,
    );
    
    // Update result with final XP
    final finalResult = GameResult(
      puzzle: result.puzzle,
      elapsed: result.elapsed,
      mistakes: result.mistakes,
      hintsUsed: result.hintsUsed,
      xpEarned: xp,
      difficulty: result.difficulty,
    );

    bool leveledUp = false;
    int previousLevel = 1;
    int newLevel = 1;
    List<String> newAchievements = [];

    // Persist stats.
    try {
      final db = DbService.instance;
      
      final currentStats = await db.userStats.getStats();
      previousLevel = currentStats?.level ?? 1;

      await db.userStats.addXP(xp);
      await db.userStats.incrementPuzzleCount(difficulty.value.name);
      
      final updatedStats = await db.userStats.getStats();
      newLevel = updatedStats?.level ?? 1;
      leveledUp = newLevel > previousLevel;

      if (updatedStats != null) {
         newAchievements = await AchievementService.to.checkAndUnlock(updatedStats, finalResult, isDaily: isDaily);
      }

      if (_savedGameId != null) {
        await db.savedGames.deleteGame(_savedGameId!);
        _savedGameId = null;
      }
    } catch (e) {
      debugPrint("Error saving stats: $e");
    }

    if (isDaily && Get.isRegistered<DailyController>()) {
      Get.find<DailyController>().onDailyComplete(finalResult);
    }
    
    if (Get.isRegistered<EventController>()) {
      Get.find<EventController>().onPuzzleComplete();
    }

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().refreshState();
    }

    // Push to Firestore Leaderboard
    try {
      if (Get.isRegistered<FirestoreService>()) {
        await Get.find<FirestoreService>().pushLeaderboardScore(difficulty.value, finalResult);
      }
    } catch (_) {}

    // Navigate to win screen with gamification payloads
    Get.offNamed('/win', arguments: {
      'result': finalResult,
      'leveledUp': leveledUp,
      'newLevel': newLevel,
      'newAchievements': newAchievements,
    });
  }

  static List<List<int>> _deepCopy(List<List<int>> g) =>
      [for (final row in g) List<int>.of(row)];

  static List<List<int>> _decode2D(String json) {
    final outer = jsonDecode(json) as List;
    return outer.map((row) => List<int>.from(row as List)).toList();
  }
}
