// lib/core/puzzle/sudoku_solver.dart

/// Backtracking Sudoku solver.
class SudokuSolver {
  /// Solves [grid] in-place. Returns `true` if a solution was found.
  ///
  /// [grid] must be a 9×9 list of lists with 0 representing empty cells.
  static bool solve(List<List<int>> grid) {
    final empty = _findEmpty(grid);
    if (empty == null) return true; // All cells filled → solved.

    final (row, col) = empty;
    for (var num = 1; num <= 9; num++) {
      if (_isValid(grid, row, col, num)) {
        grid[row][col] = num;
        if (solve(grid)) return true;
        grid[row][col] = 0;
      }
    }
    return false;
  }

  /// Counts the number of solutions for [grid], stopping at [max] (default 2).
  ///
  /// Use this to verify that a puzzle has a unique solution:
  /// ```dart
  /// assert(SudokuSolver.countSolutions(puzzle) == 1);
  /// ```
  static int countSolutions(List<List<int>> grid, {int max = 2}) {
    // Deep-copy so we don't mutate the caller's grid.
    final copy = _deepCopy(grid);
    return _count(copy, max);
  }

  // ── private helpers ──────────────────────────────────────────────────────

  static int _count(List<List<int>> grid, int max) {
    final empty = _findEmpty(grid);
    if (empty == null) return 1; // One more solution found.

    final (row, col) = empty;
    var total = 0;
    for (var num = 1; num <= 9; num++) {
      if (_isValid(grid, row, col, num)) {
        grid[row][col] = num;
        total += _count(grid, max);
        grid[row][col] = 0;
        if (total >= max) return total; // Early exit.
      }
    }
    return total;
  }

  static (int, int)? _findEmpty(List<List<int>> grid) {
    for (var r = 0; r < 9; r++) {
      for (var c = 0; c < 9; c++) {
        if (grid[r][c] == 0) return (r, c);
      }
    }
    return null;
  }

  static bool _isValid(List<List<int>> grid, int row, int col, int num) {
    // Row check.
    if (grid[row].contains(num)) return false;
    // Column check.
    for (var r = 0; r < 9; r++) {
      if (grid[r][col] == num) return false;
    }
    // 3×3 box check.
    final boxRow = (row ~/ 3) * 3;
    final boxCol = (col ~/ 3) * 3;
    for (var r = boxRow; r < boxRow + 3; r++) {
      for (var c = boxCol; c < boxCol + 3; c++) {
        if (grid[r][c] == num) return false;
      }
    }
    return true;
  }

  static List<List<int>> _deepCopy(List<List<int>> grid) =>
      [for (final row in grid) List<int>.of(row)];
}
