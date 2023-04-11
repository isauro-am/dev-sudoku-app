import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/ui/sudoku_board/widgets/utils.dart';

import '../../../colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/sudoku_cell.dart';
import '../../../domain/sudoku_model.dart';

List<Widget> drawPanel() {
  List<Widget> column = [
    const SizedBox(
      height: 10,
    )
  ];

  //  Create the 9x9 Sudoku Board
  column.add(cubeFile(0));
  column.add(cubeFile(3));
  column.add(cubeFile(6));

  return column;
}

Row drawRow(int x) {
  int y = 0;
  List<Widget> row = [];

  while (y < 9) {
    SudokuCell sudokuCell = sudokuBoard.cells!["$x,$y"]!;

    row.add(
      Material(
        elevation: (sudokuCell.bySystem)
            ? 5
            : (sudokuCell.value == gameControl.selected && sudokuCell.value > 0)
                ? 20
                : 0,
        child: InkWell(
          onTap: () {
            // if (!gameControl.noteMode) {
            //   sudokuCell.notes = [];
            //   sudokuCell.hadNotes = false;

            //   gameControl.setPos(x, yy);
            //   if (!sudokuCell.bySystem &&
            //       gameControl.selected == 0 &&
            //       sudokuBoard.clues > 0) {
            //     sudokuCell.value = sudokuCell.solution;
            //     sudokuCell.bySystem = (sudokuCell.value != 0) ? true : false;
            //     sudokuBoard.clues--;
            //   } else if (!sudokuCell.bySystem &&
            //       sudokuCell.value != gameControl.selected) {
            //     sudokuCell.value = gameControl.selected;
            //     sudokuCell.error = groupLimitsError(x, yy);

            //     if (sudokuCell.error) {
            //       sudokuBoard.error++;
            //     }
            //   } else if (!sudokuCell.bySystem) {
            //     sudokuCell.value = 0;
            //     gameControl.setRowCol(10, 10);
            //     sudokuCell.error = false;
            //   }

            //   completed();
            // } else if (!sudokuCell.bySystem) {
            //   // SET NOTE
            //   sudokuCell.value = 0;
            //   sudokuCell.error = groupLimitsError(x, yy);
            //   gameControl.setRowCol(10, 10);
            //   setNotes(sudokuCell);
            // }

            // gameControl.update();
          },
          child: Container(
            decoration: BoxDecoration(
              color: (sudokuCell.bySystem)
                  ? customColors.blueLight
                  : (sudokuCell.error)
                      ? customColors.error
                      : (gameControl.selected == sudokuCell.value &&
                              sudokuCell.value != 0)
                          ? customColors.blueLight
                          : customColors.blueLightTransparent,
              border: Border.all(
                width: 2,
                color: (gameControl.selected == sudokuCell.value &&
                        sudokuCell.value != 0)
                    ? customColors.error
                    : customColors.blueLightTransparent,
              ),
              // color: toSet2,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            height: 40.h,
            width: 36.w,
            child: Center(
              child: displayNoteValue(sudokuCell),
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
  if (gameControl.selected != 0) {
    sudokuCell.hadNotes = true;
    sudokuCell.value = 0;

    bool contains = false;

    try {
      contains = sudokuCell.notes!.contains("${gameControl.selected}");
    } catch (e) {
      sudokuCell.notes = [];
      contains = false;
    }

    if (contains == false) {
      sudokuCell.notes?.add("${gameControl.selected}");
    } else {
      sudokuCell.notes?.remove("${gameControl.selected}");
    }

    if (sudokuCell.notes == null || sudokuCell.notes == []) {
      sudokuCell.hadNotes = false;
    } else {
      sudokuCell.hadNotes = true;
    }
  }
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
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: customColors.black),
    ),
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

  return Material(
    elevation: (sudokuBoard.selected == "$x,$y") ? 5 : 0,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: colors[0],
        ),
        color: colors[1],
      ),
      width: 36.w,
      height: 38.h,
      child: TextButton(
        onPressed: () {
          validateCell(sudokuCell);
        },
        child: Text(
          (sudokuCell.value == 0) ? "" : sudokuCell.value.toString(),
          style: TextStyle(
            color: colors[2],
            fontSize: 20,
            fontWeight: (sudokuCell.bySystem == true)
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    ),
  );
}

validateCell(SudokuCell sudokuCell) {
  // Set or remove value
  if (!sudokuCell.bySystem) {
    if (gameControl.selected != 0 && sudokuCell.value != gameControl.selected) {
      sudokuCell.value = gameControl.selected;
    } else {
      sudokuCell.value = 0;
    }
  }

  sudokuBoard.selected = "${sudokuCell.column},${sudokuCell.row}";

  gameControl.update();
}
