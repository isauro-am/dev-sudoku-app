import 'package:sudoku/models/models.dart';
import 'package:sudoku/models/sudoku_cell.dart';
import 'package:sudoku_api/sudoku_api.dart';

saveSudoku(Puzzle puzzle, bool isSolution) {
  int x = 0;

  while (x < 9) {
    int y = 0;

    while (y < 9) {
      SudokuCell sc = SudokuCell();

      int? value;

      if (isSolution) {
        value =
            puzzle.solvedBoard()?.cellAt(Position(column: y, row: x)).getValue();
      } else {
        value =
            puzzle.board()?.cellAt(Position(column: y, row: x)).getValue();
      }

      value = (value == null) ? 0 : value;

      sc.value = value;
      sc.bySystem = (value > 0) ? true : false;

      if (isSolution) {
        sudoku.solution!["$x,$y"] = sc;
      } else {
        sudoku.cells!["$x,$y"] = sc;
      }

      y++;
    }

    x++;
  }
}

createSudoku(Puzzle pluzze) {
  sudoku.solution = {};
  sudoku.cells = {};
  saveSudoku(pluzze, true);
  saveSudoku(pluzze, false);

}
