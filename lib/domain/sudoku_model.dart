import 'package:flutter/material.dart';
import 'package:sudoku/domain/game_control.dart';
import 'package:sudoku/domain/routes.dart';
import 'package:sudoku/domain/sudoku_cell.dart';
import 'package:sudoku_api/sudoku_api.dart';

Sudoku sudokuBoard = Sudoku();

class SudokuStatus {
  static const String clues = 'clues';
  static const String input = 'input';
  static const String noteMode = 'noteMode';
}

class Sudoku {
  Sudoku({
    this.cells,
  });

  String mode = SudokuStatus.input;

  int points = 1000;
  int error = 0;
  int clues = gameControl.cluesLimit;

  Map<String, int>? values = {};
  Map<String, int>? solved = {};
  Map<String, bool>? bySystem = {};

  Map<String, SudokuCell>? cells;

  void newBoard(BuildContext context) {
    Puzzle puzzle = Puzzle(
      PuzzleOptions(
        patternName: gameControl.patternName,
        clues: gameControl.dificult,
      ),
    );
    puzzle.generate().then(
      (_) {
        // Reset instance of the sudoku board
        sudokuBoard.points = 1000;
        sudokuBoard.error = 0;
        sudokuBoard.cells = {};

        setRowColumns(puzzle);

        // Navigate to the game screen
        customRoutes.navigator(context, customRoutes.game);
      },
    );
  }

  isCompleted() {
    int completed = 0;

    values!.forEach(
      (key, value) {
        if (value == solved![key]) {
          completed++;
        }
      },
    );

    return (completed == 81) ? true : false;
  }

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

        values!["$x,$y"] = value;
        solved!["$x,$y"] = solution;
        bySystem!["$x,$y"] = (value > 0) ? true : false;

        y++;
      }

      x++;
    }
  }
}
