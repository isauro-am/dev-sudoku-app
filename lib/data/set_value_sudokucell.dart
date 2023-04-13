import 'package:sudoku/domain/game_control.dart';

import '../constants/game_tags.dart';
import '../domain/sudoku_model.dart';
import 'error_handler_sudokucell.dart';

void setSudokuCellValues(int value) {
  if (value != 0) {
    if (gameControl.mode != gameTags.modeNotes) {
      setSudokuCellValue(value);
    } else {
      setSudokuCellNote(value);
    }

    // Check for errors in the row and column
    checkAllPad();
  }
}

/// This function sets the value of a cell in a Sudoku board and checks for errors in the row, column,
/// or sector.
///
/// Args:
///   value (int): The value to be set in the Sudoku cell.
void setSudokuCellValue(int value) {
  int x = int.parse(sudokuBoard.selected.split(',')[0]);
  int y = int.parse(sudokuBoard.selected.split(',')[1]);

  if (value > 0 && !sudokuBoard.cells!['$x,$y']!.bySystem) {
    sudokuBoard.cells!['$x,$y']!.value =
        (value == sudokuBoard.cells!['$x,$y']!.value) ? 0 : value;
    sudokuBoard.cells!['$x,$y']!.notes = null;
    sudokuBoard.cells!['$x,$y']!.hadNotes = false;
    sudokuBoard.cells!['$x,$y']!.error = false;
  }

  // Check for errors in the row and column or sector and increment error count
  incrementError(x, y, value);
}

/// This function sets the note of a selected cell in a Sudoku board.
///
/// Args:
///   value (int): The value parameter represents the number that the user wants to add or remove as a
/// note in a selected cell of a Sudoku board.
void setSudokuCellNote(int value) {
  int x = int.parse(sudokuBoard.selected.split(',')[0]);
  int y = int.parse(sudokuBoard.selected.split(',')[1]);

  sudokuBoard.cells!['$x,$y']!.value = 0;

  if (value > 0 && !sudokuBoard.cells!['$x,$y']!.bySystem) {
    sudokuBoard.cells!['$x,$y']!.addNote(value);
  }
}
