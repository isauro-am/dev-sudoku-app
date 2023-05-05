import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/domain/game_control.dart';
import 'package:sudoku/domain/routes.dart';
import 'package:sudoku/domain/sudoku_cell.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../ui/sudoku/bloc/sudoku_bloc.dart';

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

  int points = 0;
  int error = 0;
  int clues = gameControl.cluesLimit;
  bool completed = false;

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
        sudokuBoard.points = 100;
        sudokuBoard.error = 0;
        sudokuBoard.cells = {};

        setRowColumns(puzzle);

        // Navigate to the game screen
        customRoutes.navigator(context, customRoutes.game);
      },
    );
  }

  isCompleted(BuildContext context) {
    int n = 0;

    values!.forEach(
      (key, value) {
        if (value == solved![key]) {
          n++;
        }
      },
    );

    completed = (n == 81) ? true : false;

    if (completed) {
      context.read<SudokuBloc>().add(SudokuCompletedEvent());
    }

    return (n == 81) ? true : false;
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
