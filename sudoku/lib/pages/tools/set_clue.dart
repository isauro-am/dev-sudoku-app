import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/services.dart';

Color getColor(int x, int y) {
  bool odd = (x > 2 && x < 6) ? true : false;

  Color a = (odd) ? customColors.grey : customColors.background;
  Color b = (odd) ? customColors.background : customColors.grey;

  Color toSet = (y > 2 && y < 6) ? a : b;
  int match = gameController.matchColRow(x, y);
  toSet = (match == 1) ? customColors.greenLight : toSet;
  toSet = (match == 2) ? customColors.green : toSet;

  // if (groupLimitsError(x, y)) {
  //   toSet = customColors.error;
  // }

  if (sudoku.cells!['$x,$y']!.error) {
    toSet = customColors.error;
  }

  return toSet;
}

groupLimitsError(int x, int y) {
  bool error = false;
  if (x < 3 && y < 3) {
    error = checkErrorBox(0, 3, 0, 3, x, y);
  }
  if (x < 3 && y > 2 && y < 6) {
    error = checkErrorBox(0, 3, 3, 6, x, y);
  }
  if (x < 3 && y > 5 && y < 9) {
    error = checkErrorBox(0, 3, 6, 9, x, y);
  }

  // ------------------------

  if (x > 2 && x < 6 && y < 3) {
    error = checkErrorBox(3, 6, 0, 3, x, y);
  }
  if (x > 2 && x < 6 && y > 2 && y < 6) {
    error = checkErrorBox(3, 6, 3, 6, x, y);
  }
  if (x > 2 && x < 6 && y > 5 && y < 9) {
    error = checkErrorBox(3, 6, 6, 9, x, y);
  }

  // ------------------------

  if (x > 5 && x < 9 && y < 3) {
    error = checkErrorBox(6, 9, 0, 3, x, y);
  }
  if (x > 5 && x < 9 && y > 2 && y < 6) {
    error = checkErrorBox(6, 9, 3, 6, x, y);
  }
  if (x > 5 && x < 9 && y > 5 && y < 9) {
    error = checkErrorBox(6, 9, 6, 9, x, y);
  }

  return error;
}

checkErrorBox(int xMin, int xMax, int yMin, int yMax, int x, int y) {
  int value = sudoku.cells!['$x,$y']!.value;
  bool bySystem = sudoku.cells!['$x,$y']!.bySystem;

  while (xMin < xMax) {
    int xx = xMin * 1;
    int yy = yMin;
    while (yy < yMax) {
      if (sudoku.cells!['$xx,$yy']!.value == value && value != 0) {
        if (xx != x || yy != y) {
          if (!bySystem) {
            return true;
          }
        }
      }
      yy ++;
    }
    xMin++;
  }
  return false;
}
