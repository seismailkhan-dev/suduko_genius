// lib/core/puzzle/sudoku_generator.dart

import 'dart:math';

import 'models.dart';
import 'sudoku_solver.dart';

/// Generates valid, uniquely-solvable Sudoku puzzles.
class SudokuGenerator {
  SudokuGenerator._();

  // ── Public API ────────────────────────────────────────────────────────────

  /// Generates a random puzzle at the requested [difficulty].
  static SudokuPuzzle generate(Difficulty difficulty) {
    final rng = Random();
    return _buildPuzzle(difficulty, rng);
  }

  /// Generates a deterministic puzzle for a given date string (e.g. "2024-03-10").
  ///
  /// Same [dateStr] always produces the same puzzle, which is used for
  /// the Daily Challenge feature.
  static SudokuPuzzle generateForDate(String dateStr) {
    final seed = _hashString(dateStr);
    final rng = Random(seed);
    return _buildPuzzle(Difficulty.medium, rng, id: 'daily_$dateStr');
  }

  // ── Core builder ──────────────────────────────────────────────────────────

  static SudokuPuzzle _buildPuzzle(
    Difficulty difficulty,
    Random rng, {
    String? id,
  }) {
    // 1. Generate a fully solved grid.
    final solution = _createFilledGrid(rng);

    // 2. Determine how many givens to keep.
    final (minGivens, maxGivens) = difficulty.givenRange;
    final targetGivens =
        minGivens + rng.nextInt((maxGivens - minGivens + 1).clamp(1, 99));

    // 3. Remove cells while maintaining a unique solution.
    final puzzle = _digHoles(solution, targetGivens, rng);

    return SudokuPuzzle(
      id: id ?? _randomId(rng),
      puzzle: puzzle,
      solution: solution,
      difficulty: difficulty,
      createdAt: DateTime.now(),
    );
  }

  // ── Grid filler (backtracking with shuffled candidates) ───────────────────

  static List<List<int>> _createFilledGrid(Random rng) {
    final grid = List.generate(9, (_) => List.filled(9, 0));
    _fillGrid(grid, rng);
    return grid;
  }

  static bool _fillGrid(List<List<int>> grid, Random rng) {
    for (var row = 0; row < 9; row++) {
      for (var col = 0; col < 9; col++) {
        if (grid[row][col] != 0) continue;

        final candidates = _shuffled([1, 2, 3, 4, 5, 6, 7, 8, 9], rng);
        for (final num in candidates) {
          if (_isValid(grid, row, col, num)) {
            grid[row][col] = num;
            if (_fillGrid(grid, rng)) return true;
            grid[row][col] = 0;
          }
        }
        return false; // Trigger backtrack.
      }
    }
    return true; // All cells filled.
  }

  // ── Hole digger ───────────────────────────────────────────────────────────

  static List<List<int>> _digHoles(
    List<List<int>> solution,
    int targetGivens,
    Random rng,
  ) {
    final puzzle = _deepCopy(solution);

    // Build a shuffled list of all 81 positions.
    final positions = [
      for (var r = 0; r < 9; r++)
        for (var c = 0; c < 9; c++) (r, c),
    ]..shuffle(rng);

    var givens = 81;

    for (final (r, c) in positions) {
      if (givens <= targetGivens) break;

      final backup = puzzle[r][c];
      puzzle[r][c] = 0;

      // Only keep the hole if the puzzle still has a unique solution.
      if (SudokuSolver.countSolutions(puzzle) == 1) {
        givens--;
      } else {
        puzzle[r][c] = backup; // Restore.
      }
    }

    return puzzle;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  static bool _isValid(List<List<int>> grid, int row, int col, int num) {
    if (grid[row].contains(num)) return false;
    for (var r = 0; r < 9; r++) {
      if (grid[r][col] == num) return false;
    }
    final br = (row ~/ 3) * 3;
    final bc = (col ~/ 3) * 3;
    for (var r = br; r < br + 3; r++) {
      for (var c = bc; c < bc + 3; c++) {
        if (grid[r][c] == num) return false;
      }
    }
    return true;
  }

  static List<T> _shuffled<T>(List<T> list, Random rng) {
    final copy = List<T>.of(list)..shuffle(rng);
    return copy;
  }

  static List<List<int>> _deepCopy(List<List<int>> grid) =>
      [for (final row in grid) List<int>.of(row)];

  static String _randomId(Random rng) =>
      List.generate(12, (_) => rng.nextInt(16).toRadixString(16)).join();

  /// Stable string hash (djb2-variant) used for seeding the date RNG.
  static int _hashString(String s) {
    var hash = 5381;
    for (final codeUnit in s.codeUnits) {
      hash = ((hash << 5) + hash) ^ codeUnit;
    }
    return hash;
  }
}
