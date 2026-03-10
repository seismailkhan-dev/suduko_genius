// lib/features/game/widgets/sudoku_board.dart

import 'package:flutter/material.dart';

import '../../../app/theme/app_theme.dart';
import 'sudoku_cell.dart';

/// 9×9 Sudoku grid layout.
///
/// Thin lines separate individual cells; thick lines separate the 3×3 boxes.
class SudokuBoardWidget extends StatelessWidget {
  const SudokuBoardWidget({super.key});

  // Visual constants
  static const double _thinBorder = 0.5;
  static const double _thickBorder = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<GameColors>();
    
    final thinColor = colors?.cellBorder ?? theme.dividerColor;
    final thickColor = theme.colorScheme.primary;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: thickColor, width: _thickBorder),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: List.generate(9, (row) {
            return Expanded(
              child: Row(
                children: List.generate(9, (col) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: row == 0
                              ? BorderSide.none
                              : row % 3 == 0
                                  ? BorderSide(color: thickColor, width: _thickBorder)
                                  : BorderSide(color: thinColor, width: _thinBorder),
                          left: col == 0
                              ? BorderSide.none
                              : col % 3 == 0
                                  ? BorderSide(color: thickColor, width: _thickBorder)
                                  : BorderSide(color: thinColor, width: _thinBorder),
                        ),
                      ),
                      child: SudokuCell(row: row, col: col),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}

