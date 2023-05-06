import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../domain/sudoku_model.dart';

bool isBySystem(List<int> position) {
  String strPosition = '${position[0]},${position[1]}';
  return sudokuBoard.bySystem![strPosition] ?? false;
}

Color cellColor(bool selected, bool error, bool bySystem) {
  if (selected && !error) {
    return customColors.selectedRow;
  } else if (error) {
    return customColors.error;
  } else if (bySystem) {
    return customColors.bgBySystem;
  } else {
    return customColors.bgByUser;
  }
}

bool crossSelection(List<int> selected, List<int> cell) {
  if (selected[0] == cell[0] || selected[1] == cell[1]) {
    return true;
  } else if (selected[0] ~/ 3 == cell[0] ~/ 3 &&
      selected[1] ~/ 3 == cell[1] ~/ 3) {
    return true;
  } else {
    return false;
  }
}

bool crossSelectionError(List<int> cell, int value) {
  bool error = false;

  int x = 0;
  while (x < 9) {
    if (sudokuBoard.values!['$x,${cell[1]}'] == value) {
      if (cell[0] != x && value != 0) {
        error = true;
      }
    }
    x++;
  }

  int y = 0;
  while (y < 9) {
    if (sudokuBoard.values!['${cell[0]},$y'] == value) {
      if (cell[1] != y && value != 0) {
        error = true;
      }
    }
    y++;
  }

  int xx = 0;
  while (xx < 3) {
    int yy = 0;
    while (yy < 3) {
      if (sudokuBoard
              .values!['${cell[0] ~/ 3 * 3 + xx},${cell[1] ~/ 3 * 3 + yy}'] ==
          value) {
        if (cell[0] != cell[0] ~/ 3 * 3 + xx &&
            cell[1] != cell[1] ~/ 3 * 3 + yy &&
            value != 0) {
          error = true;
        }
      }
      yy++;
    }
    xx++;
  }

  return error;
}
