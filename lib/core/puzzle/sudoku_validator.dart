// lib/core/puzzle/sudoku_validator.dart

/// Pure validation helpers for Sudoku grids.
class SudokuValidator {
  SudokuValidator._();

  /// Returns `true` if placing [num] at ([row], [col]) in [grid] is legal
  /// (does not violate row, column, or 3×3 box constraints).
  ///
  /// The cell at ([row], [col]) is ignored when checking, so you can call this
  /// before writing [num] into the cell.
  static bool isValidPlacement(
    List<List<int>> grid,
    int row,
    int col,
    int num,
  ) {
    // Row.
    for (var c = 0; c < 9; c++) {
      if (c != col && grid[row][c] == num) return false;
    }
    // Column.
    for (var r = 0; r < 9; r++) {
      if (r != row && grid[r][col] == num) return false;
    }
    // 3×3 box.
    final boxRow = (row ~/ 3) * 3;
    final boxCol = (col ~/ 3) * 3;
    for (var r = boxRow; r < boxRow + 3; r++) {
      for (var c = boxCol; c < boxCol + 3; c++) {
        if ((r != row || c != col) && grid[r][c] == num) return false;
      }
    }
    return true;
  }

  /// Returns `true` when every cell in [grid] is filled (no zeros).
  static bool isBoardComplete(List<List<int>> grid) {
    for (final row in grid) {
      if (row.contains(0)) return false;
    }
    return true;
  }

  /// Returns `true` when [grid] matches [solution] exactly in every cell.
  static bool isBoardCorrect(
    List<List<int>> grid,
    List<List<int>> solution,
  ) {
    for (var r = 0; r < 9; r++) {
      for (var c = 0; c < 9; c++) {
        if (grid[r][c] != solution[r][c]) return false;
      }
    }
    return true;
  }

  /// Returns all cell coordinates that share the same row, column, or 3×3 box
  /// as ([row], [col]), excluding ([row], [col]) itself.
  ///
  /// The list may contain duplicates where row and box overlap – duplicates are
  /// removed before returning.
  static List<(int, int)> getRelatedCells(int row, int col) {
    final Set<(int, int)> related = {};

    // Same row.
    for (var c = 0; c < 9; c++) {
      if (c != col) related.add((row, c));
    }
    // Same column.
    for (var r = 0; r < 9; r++) {
      if (r != row) related.add((r, col));
    }
    // Same 3×3 box.
    final boxRow = (row ~/ 3) * 3;
    final boxCol = (col ~/ 3) * 3;
    for (var r = boxRow; r < boxRow + 3; r++) {
      for (var c = boxCol; c < boxCol + 3; c++) {
        if (r != row || c != col) related.add((r, c));
      }
    }
    return related.toList();
  }
}
