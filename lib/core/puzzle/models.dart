// lib/core/puzzle/models.dart

/// Difficulty levels with associated clue counts.
enum Difficulty {
  easy,
  medium,
  hard,
  master,
  extreme;

  /// Range of given cells for this difficulty [min, max].
  (int, int) get givenRange => switch (this) {
        Difficulty.easy => (36, 46),
        Difficulty.medium => (27, 35),
        Difficulty.hard => (22, 26),
        Difficulty.master => (17, 21),
        Difficulty.extreme => (0, 16),
      };

  String get displayName => switch (this) {
        Difficulty.easy => 'Easy',
        Difficulty.medium => 'Medium',
        Difficulty.hard => 'Hard',
        Difficulty.master => 'Master',
        Difficulty.extreme => 'Extreme',
      };
}

/// An immutable Sudoku puzzle snapshot.
class SudokuPuzzle {
  const SudokuPuzzle({
    required this.id,
    required this.puzzle,
    required this.solution,
    required this.difficulty,
    required this.createdAt,
  });

  /// Unique identifier (UUID or date string for dailies).
  final String id;

  /// 9×9 grid of given digits; 0 means empty.
  final List<List<int>> puzzle;

  /// Complete, unique solution.
  final List<List<int>> solution;

  final Difficulty difficulty;
  final DateTime createdAt;

  SudokuPuzzle copyWith({
    String? id,
    List<List<int>>? puzzle,
    List<List<int>>? solution,
    Difficulty? difficulty,
    DateTime? createdAt,
  }) =>
      SudokuPuzzle(
        id: id ?? this.id,
        puzzle: puzzle ?? this.puzzle,
        solution: solution ?? this.solution,
        difficulty: difficulty ?? this.difficulty,
        createdAt: createdAt ?? this.createdAt,
      );
}

/// Mutable runtime state for a single cell.
class CellState {
  CellState({
    this.value = 0,
    this.isGiven = false,
    this.isError = false,
    this.isSelected = false,
    this.isHighlighted = false,
    Set<int>? notes,
  }) : notes = notes ?? {};

  /// 0 = empty, 1–9 = filled.
  int value;

  /// True when the cell is part of the original clue.
  bool isGiven;

  /// True when the cell value conflicts with the solution / rules.
  bool isError;

  /// True when this cell is currently focused.
  bool isSelected;

  /// True when this cell shares row/col/box with the selected cell.
  bool isHighlighted;

  /// Pencil-mark notes the player has placed in this cell.
  Set<int> notes;

  CellState copyWith({
    int? value,
    bool? isGiven,
    bool? isError,
    bool? isSelected,
    bool? isHighlighted,
    Set<int>? notes,
  }) =>
      CellState(
        value: value ?? this.value,
        isGiven: isGiven ?? this.isGiven,
        isError: isError ?? this.isError,
        isSelected: isSelected ?? this.isSelected,
        isHighlighted: isHighlighted ?? this.isHighlighted,
        notes: notes ?? Set.of(this.notes),
      );
}

/// Summary produced when a game session ends.
class GameResult {
  const GameResult({
    required this.puzzle,
    required this.elapsed,
    required this.mistakes,
    required this.hintsUsed,
    required this.xpEarned,
    required this.difficulty,
  });

  final SudokuPuzzle puzzle;
  final Duration elapsed;
  final int mistakes;
  final int hintsUsed;
  final int xpEarned;
  final Difficulty difficulty;
}
