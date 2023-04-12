// To parse this JSON data, do
//
//     final sudoku = sudokuFromJson(jsonString);

import 'package:sudoku/domain/sudoku_cell.dart';
import 'package:sudoku_api/sudoku_api.dart';

Sudoku sudokuBoard = Sudoku();

class Sudoku {
  Sudoku({
    this.points = 1000,
    this.error = 0,
    this.clues = 10,
    this.cells,
  });

  int points;
  int error;
  int clues;

  String selected = "9,9";
  
  Map<String, SudokuCell>? cells;


  void setRowColumns(Puzzle puzzle) {
    cells = {};

    int x = 0;

    while (x < 9) {
      int y = 0;

      while (y < 9) {
        SudokuCell sc = SudokuCell();

        int? value;
        int? solution;

        value = puzzle.board()?.cellAt(Position(column: x, row: y)).getValue();
        solution = puzzle
            .solvedBoard()
            ?.cellAt(Position(column: x, row: y))
            .getValue();

        value = (value == null) ? 0 : value;
        solution = (solution == null) ? 0 : solution;

        sc.column = x;
        sc.row = y;

        sc.value = value;
        sc.solution = solution;
        sc.bySystem = (value > 0) ? true : false;

        sc.column = x;
        sc.row = y;

        cells!["$x,$y"] = sc;

        y++;
      }

      x++;
    }
  }
}
