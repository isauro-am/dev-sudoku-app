import 'package:sudoku/domain/game_control.dart';

import '../domain/sudoku_model.dart';

setSudokuCellValues(int value) {
  if (!gameControl.noteMode) {
    setSudokuCellValue(value);
  } else {
    setSudokuCellNote(value);
  }
}

setSudokuCellValue(int value) {
  int x = int.parse(sudokuBoard.selected.split(',')[0]);
  int y = int.parse(sudokuBoard.selected.split(',')[1]);

  if (value > 0 && !sudokuBoard.cells!['$x,$y']!.bySystem) {
    sudokuBoard.cells!['$x,$y']!.value = value;
    sudokuBoard.cells!['$x,$y']!.notes = null;
    sudokuBoard.cells!['$x,$y']!.hadNotes = false;
  }
}

setSudokuCellNote(int value) {
  int x = int.parse(sudokuBoard.selected.split(',')[0]);
  int y = int.parse(sudokuBoard.selected.split(',')[1]);

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
