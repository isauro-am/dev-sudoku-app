

import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../models/sudoku_cell.dart';
import '../../services/services.dart';
import 'set_clue.dart';

List<Widget> drawPanel(Size size) {
  List<Widget> column = [
    const SizedBox(
      height: 10,
    )
  ];
  int x = 0;

  while (x < 9) {
    column.add(drawRow(x, size));
    x++;
  }
  return column;
}

Row drawRow(int x, Size size) {
  double width = (size.width > 400) ? 390 / 9 : (size.width - 10) / 9;
  int y = 0;
  List<Widget> row = [];

  while (y < 9) {
    int yy = y * 1;
    SudokuCell sudokuCell = sudoku.cells!["$x,$y"]!;

    int value = sudokuCell.value;

    Color toSet2 = getColor(x, yy);

    row.add(
      InkWell(
        onTap:
            () {
          gameController.setXY(x, yy);
          if (!sudokuCell.bySystem &&
              gameController.selected == 0 &&
              sudoku.clues > 0) {
            sudokuCell.value = sudokuCell.solution;
            sudokuCell.bySystem = (sudokuCell.value != 0) ? true : false;
            sudoku.clues--;
          } else if (!sudokuCell.bySystem && sudokuCell.value != gameController.selected ) {
            sudokuCell.value = gameController.selected;
            sudokuCell.error = groupLimitsError(x, yy);

            if(sudokuCell.error){
              sudoku.error++;
            }

          } else if (!sudokuCell.bySystem) {
            sudokuCell.value = 0;
            gameController.currentCol=10;
            gameController.currentRow=10;
            sudokuCell.error = false;
          }


          gameController.update();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: customColors.blueLightTransparent,
              ),
              color: toSet2,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          height: width,
          width: width,
          child: Center(
            child: Text(
              (value == 0) ? "" : value.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: (sudokuCell.bySystem == true)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );

    y++;
  }

  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: row,
  );
}
