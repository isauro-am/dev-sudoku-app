import 'package:flutter/material.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/pages/home.dart';
import 'package:sudoku/services/services.dart';

import '../models/sudoku_cell.dart';
import 'template_page.dart';

class TemplateGame extends StatefulWidget {
  const TemplateGame({Key? key}) : super(key: key);

  @override
  State<TemplateGame> createState() => _TemplateGameState();
}

class _TemplateGameState extends State<TemplateGame> {
  @override
  Widget build(BuildContext context) {
    update() {
      setState(() {});
    }

    gameController.update = update;

    Size size = MediaQuery.of(context).size;

    return CustomPageTemplate(
      appBar: false,
      background: "assets/game.png",
      size: size,
      title: "Sudoku",
      color: customColors.inputBorder,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              cluesButton(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: drawPanel(size),
          ),
          const SizedBox(
            height: 30,
          ),
          userNumberTools(1, 5, size),
          userNumberTools(5, 10, size),
          jump(1),
        ],
      ),
    );
  }
}

ElevatedButton cluesButton() {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all((gameController.clues)
          ? customColors.yellow
          : customColors.yellowLight),
    ),
    onPressed: () {
      if (gameController.clues) {
        gameController.clues = false;
        gameController.selected = 1;
      } else {
        gameController.selected = 0;
        gameController.clues = true;
      }
      gameController.update();
    },
    child: Text("HELP [${sudoku.clues}]"),
  );
}

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
  bool odd = (x > 2 && x < 6) ? true : false;

  Color a = (odd) ? customColors.grey : customColors.background;
  Color b = (odd) ? customColors.background : customColors.grey;

  double width = (size.width > 400) ? 390 / 9 : (size.width - 10) / 9;
  int y = 0;
  List<Widget> row = [];

  while (y < 9) {
    int yy = y*1;
    SudokuCell sudokuCell = sudoku.cells!["$x,$y"]!;

    Color toSet = (y > 2 && y < 6) ? a : b;

    int value = sudokuCell.value;

    int match = gameController.matchColRow(x, yy);

    if (match > 0){
      print("Current ${gameController.currentRow} ${gameController.currentCol} --> $match $x $yy");
    }

    toSet = (match == 1) ? customColors.greenLight : toSet;
    toSet = (match == 2) ? customColors.green : toSet;

    row.add(
      InkWell(
        onTap:
            // (sudokuCell.bySystem)
            //     ? null
            //     :
            () {
          gameController.setXY(x, yy);
          if (!sudokuCell.bySystem &&
              gameController.selected == 0 &&
              sudoku.clues > 0) {
            sudokuCell.value = sudokuCell.solution;
            sudokuCell.bySystem = (sudokuCell.value != 0) ? true : false;
            sudoku.clues--;
          }
          gameController.update();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: customColors.blueLightTransparent,
              ),
              color: toSet,
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

Row userNumberTools(int init, int end, Size size) {
  double width = (size.width > 400) ? 360 / 6 : (size.width - 40) / 6;

  List<Widget> row = [];

  int number = 1 * init;

  while (number < end) {
    row.add(numberSet(number, width));
    number++;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: row,
  );
}

InkWell numberSet(int n, double width) {
  return InkWell(
    onTap: () {
      gameController.selected = n;
      gameController.clues = false;
      gameController.update();
    },
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: customColors.blueLightTransparent,
          ),
          color: (gameController.selected == n)
              ? customColors.selectionAlfa
              : customColors.selectionTransparent,
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      height: width,
      width: width,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              n.toString(),
              style: TextStyle(
                fontSize: (gameController.selected == n) ? 14 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            (gameController.selected == n)
                ? const Icon(Icons.create_rounded)
                : const SizedBox(),
          ],
        ),
      ),
    ),
  );
}
