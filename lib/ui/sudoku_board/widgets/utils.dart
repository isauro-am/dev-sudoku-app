import 'package:flutter/material.dart';
import 'package:sudoku/domain/sudoku_cell.dart';

import '../../../colors.dart';
import '../../../domain/sudoku_model.dart';

List<Color> sudokuCellColors(SudokuCell sudokuCell) {
  int x = sudokuCell.column;
  int y = sudokuCell.row;

  Color borderColor = (sudokuBoard.selected == "$x,$y")
      ? customColors.white
      : customColors.boardYellow;

  Color backgroundColor = (sudokuCell.bySystem)
      ? customColors.boardBlackSystem
      : (sudokuCell.error)
          ? customColors.error
          : (sudokuBoard.selected == "$x,$y"
              // && sudokuCell.value != 0
              )
              ? customColors.boardYellow
              : customColors.boardBlack;
  Color textColor = (sudokuCell.bySystem)
      ? customColors.boardYellow
      : (sudokuCell.value == 0)
          ? customColors.white
          : (sudokuBoard.selected == "$x,$y")
              ? customColors.boardBlackSystem
              : customColors.boardYellow;

  return [borderColor, backgroundColor, textColor];
}
