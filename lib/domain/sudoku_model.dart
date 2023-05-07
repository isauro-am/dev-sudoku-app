import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/constants/navigation.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../constants/routes.dart';
import '../ui/sudoku/bloc/sudoku_bloc.dart';
import 'game_control.dart';

Sudoku sudokuBoard = Sudoku();

class SudokuStatus {
  static const String clues = 'clues';
  static const String input = 'input';
  static const String noteMode = 'noteMode';
}

class Sudoku {
  String mode = SudokuStatus.input;

  int points = 0;
  int error = 0;
  int clues = gameSettings.cluesLimits;
  bool completed = false;

  Map<String, int>? values = {};
  Map<String, int>? solved = {};
  Map<String, bool>? bySystem = {};

  void newBoard(BuildContext context) {
    values = {};
    solved = {};
    bySystem = {};

    points = 100;
    error = 0;
    clues = gameSettings.cluesLimits;
    completed = false;
    mode = SudokuStatus.input;

    Puzzle puzzle = Puzzle(
      PuzzleOptions(
        patternName: gameSettings.patternName,
        clues: gameSettings.dificult,
      ),
    );
    puzzle.generate().then(
      (_) {
        // Reset instance of the sudoku board
        setRowColumns(puzzle);

        // Navigate to the game screen
        AppNavigator.navigator(context, Routes.game);
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
    int x = 0;

    while (x < 9) {
      int y = 0;

      while (y < 9) {
        int? value;
        int? solution;

        value = puzzle.board()?.cellAt(Position(column: x, row: y)).getValue();
        solution = puzzle
            .solvedBoard()
            ?.cellAt(Position(column: x, row: y))
            .getValue();

        value = (value == null) ? 0 : value;
        solution = (solution == null) ? 0 : solution;

        values?["$x,$y"] = value;
        solved?["$x,$y"] = solution;
        bySystem?["$x,$y"] = (value > 0) ? true : false;

        y++;
      }

      x++;
    }
  }
}
