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

class DrawOneSudokuCell extends StatefulWidget {
  final int x;
  final int y;

  const DrawOneSudokuCell({
    Key? key,
    required this.x,
    required this.y,
  }) : super(key: key);

  @override
  State<DrawOneSudokuCell> createState() => _DrawOneSudokuCellState();
}

class _DrawOneSudokuCellState extends State<DrawOneSudokuCell> {
  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SudokuCell sudokuCell = sudokuBoard.cells!["${widget.x},${widget.y}"]!;

    // Add callback to update the cell when the value changes
    sudokuCell.onChange = update;

    List<Color> colors = sudokuCellColors(sudokuCell);

    sudokuCell.needElevation();

    bool same =
        (sudokuBoard.cells![sudokuBoard.selected]?.value == sudokuCell.value &&
                sudokuCell.value != 0)
            ? true
            : false;

    return Material(
      shadowColor: customColors.shadowColor,
      elevation: (sudokuBoard.selected == "${widget.x},${widget.y}") ? 5 : 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: (sudokuCell.elevation || same) ? 2 : 0,
            color:
                (sudokuCell.elevation) ? customColors.shadowColor : colors[0],
          ),
          color: (sudokuCell.error) ? customColors.error : colors[1],
        ),
        width: 10.1.vw,
        height: 6.vh,
        child: TextButton(
          onPressed: () {
            // Set selected number or note
            if (gameControl.mode == "Note" && !sudokuCell.bySystem) {
              sudokuCell.hadNotes = true;
            }

            // Set selected row and column
            sudokuBoard.setSelection("${sudokuCell.column},${sudokuCell.row}");

            // Set helped value to sudokuCell
            helpSetSudokuCellValue();

            updateSudokuCells();

            // Update the board
            gameControl.update();
          },
          child: Text(
            sudokuCell.displayValue(),
            style: TextStyle(
              color: colors[2],
              fontSize: (sudokuCell.hadNotes) ? 1.4.vh : 1.rem,
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

/// The function updates the cells in a Sudoku board based on the current and previous selections.
void updateSudokuCells() {
  int pX = int.parse(sudokuBoard.oldSelection.split(",")[0]);
  int pY = int.parse(sudokuBoard.oldSelection.split(",")[1]);

  if (pX != 9 && pY != 9) {
    for (int i = 0; i < 9; i++) {
      sudokuBoard.cells!["$i,$pY"]!.onChange();
      sudokuBoard.cells!["$pX,$i"]!.onChange();
    }
  }

  int cX = int.parse(sudokuBoard.selected.split(",")[0]);
  int cY = int.parse(sudokuBoard.selected.split(",")[1]);

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
