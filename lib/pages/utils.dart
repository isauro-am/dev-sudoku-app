import 'package:sudoku/models/models.dart';
import 'package:sudoku/domain/sudoku_cell.dart';
import 'package:sudoku_api/sudoku_api.dart';

saveSudoku(Puzzle puzzle) {
  int x = 0;

  while (x < 9) {
    int y = 0;

    while (y < 9) {
      SudokuCell sc = SudokuCell();

      int? value;
      int? solution;

      value = puzzle.board()?.cellAt(Position(column: y, row: x)).getValue();
      solution =
          puzzle.solvedBoard()?.cellAt(Position(column: y, row: x)).getValue();

      value = (value == null) ? 0 : value;
      solution = (solution == null) ? 0 : solution;

      sc.value = value;
      sc.solution = solution;
      sc.bySystem = (value > 0) ? true : false;

      // if (isSolution) {
      //   sudoku.solution!["$x,$y"] = sc;
      // } else {
      sudoku.cells!["$x,$y"] = sc;
      // }

      y++;
    }

    x++;
  }
}

createSudoku(Puzzle pluzze) {
  // sudoku.solution = {};
  sudoku.cells = {};
  saveSudoku(pluzze);
  // saveSudoku(pluzze, false);
}
