import 'package:flutter/material.dart';

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
