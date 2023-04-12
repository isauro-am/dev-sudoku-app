import 'package:sudoku/domain/game_control.dart';

import '../domain/sudoku_model.dart';
import 'error_handler_sudokucell.dart';

setSudokuCellValues(int value) {
  if (value != 0) {
    if (!gameControl.noteMode) {
      setSudokuCellValue(value);
    } else {
      setSudokuCellNote(value);
    }

    // Check for errors in the row and column
    checkAllPad();
  }
}

setSudokuCellValue(int value) {
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

setSudokuCellNote(int value) {
  int x = int.parse(sudokuBoard.selected.split(',')[0]);
  int y = int.parse(sudokuBoard.selected.split(',')[1]);

  sudokuBoard.cells!['$x,$y']!.value = 0;

  if (value > 0 && !sudokuBoard.cells!['$x,$y']!.bySystem) {
    if (sudokuBoard.cells!['$x,$y']!.notes == null) {
      sudokuBoard.cells!['$x,$y']!.notes = [];
    }
    if (sudokuBoard.cells!['$x,$y']!.notes!.contains(value.toString())) {
      sudokuBoard.cells!['$x,$y']!.notes!.remove(value.toString());
    } else {
      sudokuBoard.cells!['$x,$y']!.notes!.add(value.toString());
    }
    sudokuBoard.cells!['$x,$y']!.hadNotes = true;
  }
}