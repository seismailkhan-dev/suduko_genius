// lib/features/game/widgets/sudoku_cell.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_theme.dart';
import '../controller/game_controller.dart';

/// A single cell in the Sudoku board.
///
/// Visual states (checked reactively via Obx + GameController observables):
///  • given        → bold digit, `givenBg` background
///  • user-correct → normal weight digit, `correctBg` background
///  • user-error   → red digit, `errorBg` background
///  • selected     → violet glow / accent background
///  • highlighted  → light tinted background (same row/col/box)
///  • same-number  → extra warm highlight
///  • notes        → 3×3 mini-grid of candidate digits
///  • error-shake  → quick horizontal shake animation via AnimationController
class SudokuCell extends StatefulWidget {
  const SudokuCell({
    super.key,
    required this.row,
    required this.col,
  });

  final int row;
  final int col;

  @override
  State<SudokuCell> createState() => _SudokuCellState();
}

class _SudokuCellState extends State<SudokuCell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeCtrl;
  late final Animation<double> _shakeAnim;

  // Track previous error state to trigger shake only on new errors.
  bool _wasError = false;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _shakeAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: -4.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _shakeCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  void _triggerShake() {
    _shakeCtrl
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<GameController>();
    final key = '${widget.row},${widget.col}';

    return Obx(() {
      final isGiven = ctrl.puzzle[widget.row][widget.col] != 0;
      final value = ctrl.userGrid[widget.row][widget.col];
      final isSelected =
          ctrl.selectedRow.value == widget.row && ctrl.selectedCol.value == widget.col;
      final isHighlighted = ctrl.highlightedCells.contains(key);
      final isSameNumber = ctrl.sameNumberCells.contains(key);
      final isError = ctrl.errorCells.contains(key);
      final notes = ctrl.cellNotes[key];

      // Fire shake on new error.
      if (isError && !_wasError) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _triggerShake());
      }
      _wasError = isError;

      final theme = Theme.of(context);
      final colors = theme.extension<GameColors>();

      final bg = _resolveBg(isSelected, isHighlighted, isSameNumber, isError, isGiven, colors, theme);
      final textColor = _resolveTextColor(isGiven, isError, colors, theme);

      return AnimatedBuilder(
        animation: _shakeAnim,
        builder: (ctx, child) => Transform.translate(
          offset: Offset(_shakeAnim.value, 0),
          child: child,
        ),
        child: GestureDetector(
          onTap: () => ctrl.selectCell(widget.row, widget.col),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            decoration: BoxDecoration(
              color: bg,
              boxShadow: isSelected && colors?.cellSelected != null
                  ? [
                      BoxShadow(
                        color: colors!.cellSelected.withValues(alpha: 0.45),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: _buildCellContent(value, isGiven, textColor, notes, context),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCellContent(int value, bool isGiven, Color textColor, Set<int>? notes, BuildContext context) {
    if (value != 0) {
      return _buildDigit(value, isGiven, textColor);
    } else if (notes != null && notes.isNotEmpty) {
      return _buildNotes(notes, context);
    }
    return const SizedBox.shrink();
  }

  Widget _buildDigit(int value, bool isGiven, Color textColor) {
    if (value == 0) return const SizedBox.shrink();
    return Text(
      '$value',
      style: TextStyle(
        fontSize: 20,
        fontWeight: isGiven ? FontWeight.w800 : FontWeight.w500,
        color: textColor,
      ),
    );
  }

  Widget _buildNotes(Set<int> notes, BuildContext context) {
    final noteColor = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.55);
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(1),
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      children: List.generate(9, (i) {
        final n = i + 1;
        return Center(
          child: Text(
            notes.contains(n) ? '$n' : '',
            style: TextStyle(fontSize: 8, color: noteColor, height: 1.1),
          ),
        );
      }),
    );
  }

  Color _resolveBg(
    bool isSelected,
    bool isHighlighted,
    bool isSameNumber,
    bool isError,
    bool isGiven,
    GameColors? colors,
    ThemeData theme,
  ) {
    if (isSelected) return colors?.cellSelected ?? theme.colorScheme.primary.withValues(alpha: 0.28);
    if (isError) return theme.colorScheme.error.withValues(alpha: 0.18);
    if (isSameNumber) return colors?.cellHighlight.withValues(alpha: 0.2) ?? theme.colorScheme.primary.withValues(alpha: 0.14);
    if (isHighlighted) return colors?.cellHighlight ?? theme.colorScheme.primary.withValues(alpha: 0.07);
    if (isGiven) return colors?.boardBackground ?? theme.cardTheme.color ?? theme.colorScheme.surface;
    return colors?.boardBackground ?? theme.colorScheme.surface;
  }

  Color _resolveTextColor(bool isGiven, bool isError, GameColors? colors, ThemeData theme) {
    if (isError) return colors?.errorNumberColor ?? theme.colorScheme.error;
    if (isGiven) return colors?.givenNumberColor ?? theme.textTheme.bodyMedium?.color ?? theme.colorScheme.onSurface;
    return colors?.inputNumberColor ?? theme.colorScheme.primary;
  }
}
