import 'package:sudoku/domain/game_control.dart';

import '../domain/sudoku_model.dart';

void checkAllPad() {
  int completed = 0;

  removeErrorBySystem();
  int x = 0;
  while (x < 9) {
    int y = 0;
    while (y < 9) {

      if (sudokuBoard.cells!['$x,$y']!.value != 0) {
        findRowValue(x, y, sudokuBoard.cells!['$x,$y']!.value);
        findColumnValue(x, y, sudokuBoard.cells!['$x,$y']!.value);
        findInSector(x, y, sudokuBoard.cells!['$x,$y']!.value);
      } else {
        sudokuBoard.cells!['$x,$y']!.error = false;
      }

      if (sudokuBoard.cells!['$x,$y']!.value ==
          sudokuBoard.cells!['$x,$y']!.solution) {
        completed++;
      }

      // Update the cell
      sudokuBoard.cells!['$x,$y']!.onChange();

      y++;
    }
    x++;
  }

  // Verify if the game is completed
  if (completed == 81) {
    gameControl.completed = true;
    gameControl.setSelection("9,9");
  }
}

void incrementError(int x, int y, int value) {
  if (findRowValue(x, y, value) ||
      findColumnValue(x, y, value) ||
      findInSector(x, y, value)) {
    sudokuBoard.error++;
  }
}

void removeErrorBySystem() {
  int x = 0;
  while (x < 9) {
    int y = 0;
    while (y < 9) {
      sudokuBoard.cells!['$x,$y']!.error = false;
      y++;
    }
    x++;
  }
}

/// This function checks if a given value exists in a row of a Sudoku board and marks any errors.
///
/// Args:
///   x (int): The x-coordinate of the cell in the Sudoku board.
///   y (int): The parameter "y" represents the column index of a cell in a 9x9 Sudoku board.
///   value (int): The value parameter in the findRowValue function is an integer that represents the
/// value that we are searching for in a specific row of a Sudoku board.
///
/// Returns:
///   a boolean value indicating whether there is an error in the row of the Sudoku board where the cell
/// at position (x, y) is located.
bool findRowValue(int x, int y, int value) {
  bool error = false;
  int yy = 0;
  while (yy < 9) {
    if (sudokuBoard.cells!['$x,$yy']!.value == value) {
      if (y != yy) {
        sudokuBoard.cells!['$x,$yy']!.error = true;
        error = true;
      }
    }
    yy++;
  }
  return error;
}

/// This function checks if a given value exists in a specific column of a Sudoku board and marks any
/// errors.
///
/// Args:
///   x (int): The x parameter is not used in the given function. It is not necessary for the function
/// to work correctly.
///   y (int): The parameter "y" represents the column number in the Sudoku board.
///   value (int): The value parameter represents the value that we are searching for in a specific
/// column of a Sudoku board. The function is designed to check if the value already exists in the same
/// column as the cell located at position (x, y) on the board.
///
/// Returns:
///   a boolean value indicating whether there is an error in the column of the Sudoku board.
bool findColumnValue(int x, int y, int value) {
  bool error = false;
  int xx = 0;
  while (xx < 9) {
    if (sudokuBoard.cells!['$xx,$y']!.value == value) {
      if (x != xx) {
        sudokuBoard.cells!['$xx,$y']!.error = true;
        error = true;
      }
    }
    xx++;
  }
  return error;
}

/// The function returns the sector coordinates of a given point in a 9x9 grid.
///
/// Args:
///   x (int): The x-coordinate of a point in a grid.
///   y (int): The parameter "y" in the function "getSectorXY" represents the vertical coordinate of a
/// point in a grid system.
///
/// Returns:
///   an array with two elements: the sectorX and sectorY values calculated based on the input x and y
/// values.
List<int> getSectorXY(int x, int y) {
  int sectorX = 0;
  int sectorY = 0;

  if (x < 3) {
    sectorX = 0;
  } else if (x < 6) {
    sectorX = 3;
  } else {
    sectorX = 6;
  }

  if (y < 3) {
    sectorY = 0;
  } else if (y < 6) {
    sectorY = 3;
  } else {
    sectorY = 6;
  }

  return [sectorX, sectorY];
}

/// The function checks if a given value exists in the 3x3 sector of a Sudoku board and marks any
/// errors.
///
/// Args:
///   x (int): The x-coordinate of the cell being checked in the Sudoku board.
///   y (int): The y parameter represents the vertical coordinate of a cell in the sudoku board.
///   value (int): The value that we are searching for in the 3x3 sector of the Sudoku board.
///
/// Returns:
///   a boolean value indicating whether there is an error in the sector that contains the cell at
/// position (x, y) if the value is added to that sector.
bool findInSector(int x, int y, int value) {
  bool error = false;

  List<int> sectorXY = getSectorXY(x, y);
  int sectorX = sectorXY[0];
  int sectorY = sectorXY[1];

  int xx = sectorX;
  while (xx < sectorX + 3) {
    int yy = sectorY;
    while (yy < sectorY + 3) {
      if (sudokuBoard.cells!['$xx,$yy']!.value == value) {
        if (x != xx && y != yy) {
          sudokuBoard.cells!['$xx,$yy']!.error = true;
          error = true;
        }
      }
      yy++;
    }
    xx++;
  }
  return error;
}
