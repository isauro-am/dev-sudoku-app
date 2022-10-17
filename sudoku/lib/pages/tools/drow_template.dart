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

    Color toSet2 = getColor(x, yy);

    row.add(
      InkWell(
        onTap: () {
          if (!gameController.noteMode) {
            sudokuCell.notes = [];
            sudokuCell.hadNotes = false;

            gameController.setXY(x, yy);
            if (!sudokuCell.bySystem &&
                gameController.selected == 0 &&
                sudoku.clues > 0) {
              sudokuCell.value = sudokuCell.solution;
              sudokuCell.bySystem = (sudokuCell.value != 0) ? true : false;
              sudoku.clues--;
            } else if (!sudokuCell.bySystem &&
                sudokuCell.value != gameController.selected) {
              sudokuCell.value = gameController.selected;
              sudokuCell.error = groupLimitsError(x, yy);

              if (sudokuCell.error) {
                sudoku.error++;
              }
            } else if (!sudokuCell.bySystem) {
              sudokuCell.value = 0;
              gameController.currentCol = 10;
              gameController.currentRow = 10;
              sudokuCell.error = false;
            }

            completed();
          } else if (!sudokuCell.bySystem) {
            // SET NOTE
            sudokuCell.value = 0;
            sudokuCell.error = groupLimitsError(x, yy);
            gameController.currentCol = 10;
            gameController.currentRow = 10;
            setNotes(sudokuCell);
          }

          gameController.update();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: (gameController.selected == sudokuCell.value && sudokuCell.value != 0)
                  ? customColors.error
                  :customColors.blueLightTransparent,
              ),
              color: toSet2,
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          height: (size.height - 60) / 12,
          width: width,
          child: Center(
            child: displayNoteValue(sudokuCell),
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

displayNoteValue(SudokuCell sudokuCell) {
  if (sudokuCell.notes == null) {
    sudokuCell.notes = [];
    sudokuCell.hadNotes = false;
  }
  String list = sudokuCell.notes.toString();
  list = list.replaceAll('[', '');
  list = list.replaceAll(']', '');
  return Text(
    (sudokuCell.hadNotes)
        ? list
        : (sudokuCell.value == 0)
            ? ""
            : sudokuCell.value.toString(),
    style: TextStyle(
      fontSize: (sudokuCell.hadNotes) ? 12 : 20,
      fontWeight:
          (sudokuCell.bySystem == true) ? FontWeight.bold : FontWeight.normal,
    ),
  );
}

setNotes(SudokuCell sudokuCell) {
  if (gameController.selected != 0) {
    sudokuCell.hadNotes = true;
    sudokuCell.value = 0;

    bool contains = false;

    try {
      contains = sudokuCell.notes!.contains("${gameController.selected}");
    } catch (e) {
      sudokuCell.notes = [];
      contains = false;
    }

    if (contains == false) {
      sudokuCell.notes?.add("${gameController.selected}");
    } else {
      sudokuCell.notes?.remove("${gameController.selected}");
    }

    if (sudokuCell.notes == null || sudokuCell.notes == []) {
      sudokuCell.hadNotes = false;
    } else {
      sudokuCell.hadNotes = true;
    }
  }
}
