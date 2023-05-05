import 'package:flutter/material.dart';

import '../../../domain/game_control.dart';
import '../../../domain/sudoku_model.dart';
import 'sudoku_cell.dart';

class DrawPanel extends StatelessWidget {
  const DrawPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> column = [];
    //  Create the 9x9 Sudoku Board
    column.add(const DrawCubeSector(y: 0));
    column.add(const DrawCubeSector(y: 3));
    column.add(const DrawCubeSector(y: 6));

    return Column(
      children: column,
    );
  }
}

class DrawCubeSector extends StatelessWidget {
  final int y;

  const DrawCubeSector({
    Key? key,
    required this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> row = [];

    row.add(DrawCubeNine(x: 0, y: y));
    row.add(DrawCubeNine(x: 3, y: y));
    row.add(DrawCubeNine(x: 6, y: y));

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: row,
    );
  }
}

class DrawCubeNine extends StatelessWidget {
  final int x;
  final int y;

  const DrawCubeNine({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> column = [];

    int i = 0;

    while (i < 3) {
      column.add(DrawCubeLine(x: x, y: y + i));
      i++;
    }

    return Container(
      margin: const EdgeInsets.all(2.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: column,
      ),
    );
  }
}

class DrawCubeLine extends StatelessWidget {
  final int x;
  final int y;

  const DrawCubeLine({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> row = [];

    int i = 0;

    while (i < 3) {
      row.add(
        SudokuCellBox(
          key: Key("${x + i},$y"),
          position: [x + i, y],
        ),
      );
      i++;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: row,
    );
  }
}

/// The function updates the cells in a Sudoku board based on the current and previous selections.
void updateSudokuCells() {
  int pX = int.parse(gameControl.oldSelection.split(",")[0]);
  int pY = int.parse(gameControl.oldSelection.split(",")[1]);

  if (pX != 9 && pY != 9) {
    for (int i = 0; i < 9; i++) {
      sudokuBoard.cells!["$i,$pY"]!.onChange();
      sudokuBoard.cells!["$pX,$i"]!.onChange();
    }
  }

  int cX = int.parse(gameControl.currentSelected.split(",")[0]);
  int cY = int.parse(gameControl.currentSelected.split(",")[1]);

  if (cX == 9 || cY == 9) {
    for (int i = 0; i < 9; i++) {
      sudokuBoard.cells!["$i,$cY"]!.onChange();
      sudokuBoard.cells!["$cX,$i"]!.onChange();
    }

    for (int x = 0; x < 9; x++) {
      for (int y = 0; y < 9; y++) {
        if (sudokuBoard.cells!["$x,$y"]!.value != 0) {
          if (sudokuBoard.cells!["$x,$y"]!.value ==
              sudokuBoard.cells!["$pX,$pY"]!.value) {
            sudokuBoard.cells!["$x,$y"]!.onChange();
          }
          if (sudokuBoard.cells!["$x,$y"]!.value ==
              sudokuBoard.cells!["$cX,$cY"]!.value) {
            sudokuBoard.cells!["$x,$y"]!.onChange();
          }
        }
      }
    }
  }
}
