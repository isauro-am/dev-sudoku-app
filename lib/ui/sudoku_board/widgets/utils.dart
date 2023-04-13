import 'package:flutter/material.dart';
import 'package:sudoku/domain/sudoku_cell.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';

List<Color> sudokuCellColors(SudokuCell sudokuCell) {
  int x = sudokuCell.column;
  int y = sudokuCell.row;

  Color borderColor = (gameControl.currentSelected == "$x,$y")
      ? customColors.white
      : customColors.primary;

  Color backgroundColor = (sudokuCell.bySystem)
      ? customColors.bgBySystem
      : (sudokuCell.error)
          ? customColors.error
          : (gameControl.currentSelected == "$x,$y"
              // && sudokuCell.value != 0
              )
              ? customColors.primary
              : customColors.bgByUser;
  Color textColor = (sudokuCell.bySystem)
      ? customColors.primary
      : (gameControl.currentSelected == "$x,$y")
              ? customColors.bgBySystem
              : customColors.primary;

  return [borderColor, backgroundColor, textColor];
}
