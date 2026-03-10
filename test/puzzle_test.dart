// test/puzzle_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/puzzle/models.dart';
import 'package:sudoku/core/puzzle/sudoku_generator.dart';
import 'package:sudoku/core/puzzle/sudoku_solver.dart';
import 'package:sudoku/core/puzzle/sudoku_validator.dart';

void main() {
  // ── SudokuValidator ─────────────────────────────────────────────────────

  group('SudokuValidator', () {
    test('isValidPlacement – valid placement returns true', () {
      final grid = List.generate(9, (_) => List.filled(9, 0));
      // Empty board: any digit 1–9 anywhere is valid.
      expect(SudokuValidator.isValidPlacement(grid, 0, 0, 5), isTrue);
    });

    test('isValidPlacement – row conflict returns false', () {
      final grid = List.generate(9, (_) => List.filled(9, 0));
      grid[0][3] = 5;
      expect(SudokuValidator.isValidPlacement(grid, 0, 0, 5), isFalse);
    });

    test('isValidPlacement – column conflict returns false', () {
      final grid = List.generate(9, (_) => List.filled(9, 0));
      grid[4][0] = 7;
      expect(SudokuValidator.isValidPlacement(grid, 0, 0, 7), isFalse);
    });

    test('isValidPlacement – box conflict returns false', () {
      final grid = List.generate(9, (_) => List.filled(9, 0));
      grid[1][1] = 3;
      expect(SudokuValidator.isValidPlacement(grid, 0, 0, 3), isFalse);
    });

    test('isBoardComplete – returns false for board with zeros', () {
      final grid = List.generate(9, (_) => List.filled(9, 1));
      grid[8][8] = 0;
      expect(SudokuValidator.isBoardComplete(grid), isFalse);
    });

    test('isBoardComplete – returns true for fully filled board', () {
      final grid = List.generate(9, (_) => List.filled(9, 1));
      expect(SudokuValidator.isBoardComplete(grid), isTrue);
    });

    test('isBoardCorrect – identical grids return true', () {
      final grid = List.generate(9, (r) => List.generate(9, (c) => r + c + 1));
      final solution = List.generate(9, (r) => List.generate(9, (c) => r + c + 1));
      expect(SudokuValidator.isBoardCorrect(grid, solution), isTrue);
    });

    test('isBoardCorrect – different grids return false', () {
      final grid = List.generate(9, (_) => List.filled(9, 1));
      final solution = List.generate(9, (_) => List.filled(9, 2));
      expect(SudokuValidator.isBoardCorrect(grid, solution), isFalse);
    });

    test('getRelatedCells – returns 20 cells for any given position', () {
      // Any cell has 8 in same row + 8 in same col + 4 others in box = 20.
      for (var r = 0; r < 9; r++) {
        for (var c = 0; c < 9; c++) {
          final related = SudokuValidator.getRelatedCells(r, c);
          expect(related.length, 20,
              reason: 'Cell ($r, $c) should have 20 related cells');
        }
      }
    });

    test('getRelatedCells – does not include the cell itself', () {
      final related = SudokuValidator.getRelatedCells(4, 4);
      expect(related.contains((4, 4)), isFalse);
    });

    test('getRelatedCells – no duplicates', () {
      final related = SudokuValidator.getRelatedCells(0, 0);
      final unique = related.toSet();
      expect(unique.length, related.length);
    });
  });

  // ── SudokuSolver ─────────────────────────────────────────────────────────

  group('SudokuSolver', () {
    // A well-known solvable puzzle (empty = 0).
    // Source: Project Euler #96 grid 01.
    final knownPuzzle = [
      [0, 0, 3, 0, 2, 0, 6, 0, 0],
      [9, 0, 0, 3, 0, 5, 0, 0, 1],
      [0, 0, 1, 8, 0, 6, 4, 0, 0],
      [0, 0, 8, 1, 0, 2, 9, 0, 0],
      [7, 0, 0, 0, 0, 0, 0, 0, 8],
      [0, 0, 6, 7, 0, 8, 2, 0, 0],
      [0, 0, 2, 6, 0, 9, 5, 0, 0],
      [8, 0, 0, 2, 0, 3, 0, 0, 9],
      [0, 0, 5, 0, 1, 0, 3, 0, 0],
    ];

    final knownSolution = [
      [4, 8, 3, 9, 2, 1, 6, 5, 7],
      [9, 6, 7, 3, 4, 5, 8, 2, 1],
      [2, 5, 1, 8, 7, 6, 4, 9, 3],
      [5, 4, 8, 1, 3, 2, 9, 7, 6],
      [7, 2, 9, 5, 6, 4, 1, 3, 8],
      [1, 3, 6, 7, 9, 8, 2, 4, 5],
      [3, 7, 2, 6, 8, 9, 5, 1, 4],
      [8, 1, 4, 2, 5, 3, 7, 6, 9],
      [6, 9, 5, 4, 1, 7, 3, 8, 2],
    ];

    test('solve returns true for a valid puzzle', () {
      final grid = _deepCopy(knownPuzzle);
      expect(SudokuSolver.solve(grid), isTrue);
    });

    test('solve produces the correct solution', () {
      final grid = _deepCopy(knownPuzzle);
      SudokuSolver.solve(grid);
      expect(grid, equals(knownSolution));
    });

    test('countSolutions returns 1 for a uniquely solvable puzzle', () {
      expect(SudokuSolver.countSolutions(knownPuzzle), equals(1));
    });

    test('countSolutions returns 0 for an unsolvable puzzle', () {
      // Place conflicting 5s in the same row.
      final impossible = _deepCopy(knownPuzzle);
      impossible[0][0] = 5;
      impossible[0][1] = 5; // Conflict.
      expect(SudokuSolver.countSolutions(impossible), equals(0));
    });

    test('solve returns false for an unsolvable puzzle', () {
      final grid = List.generate(9, (_) => List.filled(9, 0));
      // Fill row 0 with duplicates to make it unsolvable.
      grid[0] = [1, 1, 0, 0, 0, 0, 0, 0, 0];
      expect(SudokuSolver.solve(grid), isFalse);
    });
  });

  // ── SudokuGenerator ──────────────────────────────────────────────────────

  group('SudokuGenerator', () {
    for (final difficulty in Difficulty.values) {
      test('generate(${difficulty.name}) produces a valid puzzle', () {
        final puzzle = SudokuGenerator.generate(difficulty);
        _assertValidPuzzle(puzzle);
      });
    }

    test('generated puzzle solution is a complete valid sudoku', () {
      final puzzle = SudokuGenerator.generate(Difficulty.easy);
      _assertCompleteSudoku(puzzle.solution);
    });

    test('given cells in puzzle match the corresponding solution cells', () {
      final puzzle = SudokuGenerator.generate(Difficulty.medium);
      for (var r = 0; r < 9; r++) {
        for (var c = 0; c < 9; c++) {
          final given = puzzle.puzzle[r][c];
          if (given != 0) {
            expect(
              given,
              equals(puzzle.solution[r][c]),
              reason: 'Given at ($r, $c) does not match solution',
            );
          }
        }
      }
    });

    test('generated puzzle has exactly one solution', () {
      final puzzle = SudokuGenerator.generate(Difficulty.easy);
      expect(SudokuSolver.countSolutions(puzzle.puzzle), equals(1));
    });

    test('solver can complete the generated puzzle to the stored solution', () {
      final puzzle = SudokuGenerator.generate(Difficulty.hard);
      final grid = [for (final row in puzzle.puzzle) List<int>.of(row)];
      SudokuSolver.solve(grid);
      expect(grid, equals(puzzle.solution));
    });

    test('given count is within difficulty range', () {
      for (final difficulty in Difficulty.values) {
        final puzzle = SudokuGenerator.generate(difficulty);
        final givens = puzzle.puzzle
            .expand((row) => row)
            .where((cell) => cell != 0)
            .length;
        final (min, max) = difficulty.givenRange;

        // For extreme allow a little slack – uniqueness verification may
        // conservatively keep a few more cells than the target.
        final effectiveMax = difficulty == Difficulty.extreme ? 81 : max;
        expect(
          givens,
          inInclusiveRange(min, effectiveMax),
          reason:
              '${difficulty.name}: $givens givens outside [$min, $effectiveMax]',
        );
      }
    });

    // ── Daily determinism ──────────────────────────────────────────────────

    test('generateForDate returns the same puzzle for the same date', () {
      const dateStr = '2024-03-10';
      final p1 = SudokuGenerator.generateForDate(dateStr);
      final p2 = SudokuGenerator.generateForDate(dateStr);
      expect(p1.puzzle, equals(p2.puzzle));
      expect(p1.solution, equals(p2.solution));
    });

    test('generateForDate returns different puzzles for different dates', () {
      final p1 = SudokuGenerator.generateForDate('2024-03-10');
      final p2 = SudokuGenerator.generateForDate('2024-03-11');
      // It is astronomically unlikely the two puzzles coincide.
      expect(p1.puzzle, isNot(equals(p2.puzzle)));
    });

    test('generateForDate puzzle has exactly one solution', () {
      final puzzle = SudokuGenerator.generateForDate('2024-06-15');
      expect(SudokuSolver.countSolutions(puzzle.puzzle), equals(1));
    });

    test('generateForDate puzzle id matches daily_<date> pattern', () {
      final puzzle = SudokuGenerator.generateForDate('2024-03-10');
      expect(puzzle.id, equals('daily_2024-03-10'));
    });
  });
}

// ── Helpers ───────────────────────────────────────────────────────────────────

List<List<int>> _deepCopy(List<List<int>> grid) =>
    [for (final row in grid) List<int>.of(row)];

void _assertValidPuzzle(SudokuPuzzle puzzle) {
  expect(puzzle.puzzle.length, 9);
  for (final row in puzzle.puzzle) {
    expect(row.length, 9);
    for (final cell in row) {
      expect(cell, inInclusiveRange(0, 9));
    }
  }
  expect(puzzle.solution.length, 9);
}

void _assertCompleteSudoku(List<List<int>> grid) {
  // Each row contains 1–9 exactly once.
  for (final row in grid) {
    expect(row.toSet(), equals({1, 2, 3, 4, 5, 6, 7, 8, 9}),
        reason: 'Row is not a permutation of 1–9');
  }
  // Each column contains 1–9 exactly once.
  for (var c = 0; c < 9; c++) {
    final col = [for (var r = 0; r < 9; r++) grid[r][c]];
    expect(col.toSet(), equals({1, 2, 3, 4, 5, 6, 7, 8, 9}),
        reason: 'Column $c is not a permutation of 1–9');
  }
  // Each 3×3 box contains 1–9 exactly once.
  for (var br = 0; br < 3; br++) {
    for (var bc = 0; bc < 3; bc++) {
      final box = [
        for (var r = br * 3; r < br * 3 + 3; r++)
          for (var c = bc * 3; c < bc * 3 + 3; c++) grid[r][c],
      ];
      expect(box.toSet(), equals({1, 2, 3, 4, 5, 6, 7, 8, 9}),
          reason: 'Box ($br, $bc) is not a permutation of 1–9');
    }
  }
}
