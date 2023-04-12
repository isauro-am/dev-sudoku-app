import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/ui/sudoku_board/widgets/utils.dart';

import '../../../colors.dart';
import '../../../data/set_clue.dart';
import '../../../domain/game_control.dart';
import '../../../domain/sudoku_cell.dart';
import '../../../domain/sudoku_model.dart';

List<Widget> drawPanel() {
  List<Widget> column = [];

  //  Create the 9x9 Sudoku Board
  column.add(cubeFile(0));
  column.add(cubeFile(3));
  column.add(cubeFile(6));

  return column;
}

Row cubeFile(int y) {
  List<Widget> row = [];

  row.add(drawCube3x3(0, y));
  row.add(drawCube3x3(3, y));
  row.add(drawCube3x3(6, y));

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: row,
  );
}

Container drawCube3x3(int x, int y) {
  List<Widget> column = [];

  int i = 0;

  while (i < 3) {
    column.add(drawRow1x3(x, y + i));
    i++;
  }

  return Container(
    margin: const EdgeInsets.all(3),
    // decoration: BoxDecoration(
    //   border: Border.all(width: 1, color: customColors.boardBlack),
    // ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: column,
    ),
  );
}

Row drawRow1x3(int x, int y) {
  List<Widget> row = [];

  int i = 0;

  while (i < 3) {
    row.add(drawCube1x1(x + i, y));
    i++;
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: row,
  );
}

drawCube1x1(x, y) {
  SudokuCell sudokuCell = sudokuBoard.cells!["$x,$y"]!;

  List<Color> colors = sudokuCellColors(sudokuCell);

  sudokuCell.needElevation();

  bool same =
      (sudokuBoard.cells![sudokuBoard.selected]?.value == sudokuCell.value && sudokuCell.value != 0)
          ? true
          : false;

  return Material(
    shadowColor: customColors.shadowColor,
    elevation: (sudokuBoard.selected == "$x,$y") ? 5 : 0,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: (sudokuCell.elevation || same) ? 2 : 0,
          color: (sudokuCell.elevation )
              ? customColors.shadowColor
              : colors[0],
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
            fontSize: (sudokuCell.hadNotes)
                ? (sudokuCell.elevation)
                    ? 9
                    : 11
                : 20,
            fontWeight: (sudokuCell.bySystem == true)
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}
