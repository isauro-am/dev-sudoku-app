import 'package:sudoku/domain/game_control.dart';

import '../domain/sudoku_model.dart';
import 'error_handler_sudokucell.dart';

/// This function sets the real value of a cell in a Sudoku board if complete certain conditions.
void helpSetSudokuCellValue() {
  if (gameControl.clues && sudokuBoard.clues > 0) {
    int x = int.parse(sudokuBoard.selected.split(',')[0]);
    int y = int.parse(sudokuBoard.selected.split(',')[1]);

    if (x != 9 && y != 9 && !sudokuBoard.cells!['$x,$y']!.bySystem) {
      sudokuBoard.cells!['$x,$y']!.bySystem = true;
      sudokuBoard.cells!['$x,$y']!.hadNotes = false;
      sudokuBoard.cells!['$x,$y']!.value =
          sudokuBoard.cells!['$x,$y']!.solution;
      sudokuBoard.clues--;
      checkAllPad();
    }
  }
  if (sudokuBoard.clues < 1) {
    gameControl.clues = false;
  }
}
