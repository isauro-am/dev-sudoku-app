import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/ui/sudoku_board/widgets/utils.dart';

import '../../../constants/colors.dart';
import '../../../data/set_clue.dart';
import '../../../domain/game_control.dart';
import '../../../domain/sudoku_cell.dart';
import '../../../domain/sudoku_model.dart';

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
      margin: const EdgeInsets.all(3),
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
      row.add(DrawOneSudokuCell(x: x + i, y: y));
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

class DrawOneSudokuCell extends StatelessWidget {
  final int x;
  final int y;

  const DrawOneSudokuCell({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SudokuCell sudokuCell = sudokuBoard.cells!["$x,$y"]!;

    List<Color> colors = sudokuCellColors(sudokuCell);

    sudokuCell.needElevation();

    bool same =
        (sudokuBoard.cells![sudokuBoard.selected]?.value == sudokuCell.value &&
                sudokuCell.value != 0)
            ? true
            : false;

    return Material(
      shadowColor: customColors.shadowColor,
      elevation: (sudokuBoard.selected == "$x,$y") ? 5 : 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: (sudokuCell.elevation || same) ? 2 : 0,
            color:
                (sudokuCell.elevation) ? customColors.shadowColor : colors[0],
          ),
          color: (sudokuCell.error) ? customColors.error : colors[1],
        ),
        width: 36.w,
        height: 38.h,
        child: TextButton(
          onPressed: () {
            // Set selected number or note
            if (gameControl.noteMode && !sudokuCell.bySystem) {
              sudokuCell.hadNotes = true;
            }

            // Set selected row and column
            sudokuBoard.selected = "${sudokuCell.column},${sudokuCell.row}";

            // Set helped value to sudokuCell
            helpSetSudokuCellValue();

            // Update the board
            gameControl.update();
          },
          child: Text(
            sudokuCell.displayValue(),
            style: TextStyle(
              color: colors[2],
              fontSize: (sudokuCell.hadNotes) ? 0.7.rem : 1.rem,
              fontWeight: (sudokuCell.bySystem == true)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
