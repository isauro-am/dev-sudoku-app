import 'package:flutter/material.dart';
import 'package:sudoku/domain/game_control.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/services/services.dart';

import 'widgets/board.dart';
import 'widgets/number_pad.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({Key? key}) : super(key: key);

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  @override
  Widget build(BuildContext context) {
    update() {
      setState(() {});
    }

    gameControl.update = update; 

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: noteButton(),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (gameController.completed) ? const SizedBox() : errorButton(),
                exitButton(context),
                (gameController.completed) ? const SizedBox() : cluesButton(),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: customColors.white,
                  width: 2.0,
                ),
                // color: Colors.amberAccent,
                // image: const DecorationImage(
                //   image: AssetImage('assets/tiles_wallpaper/system.jpg'),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Column(
                children: drawPanel(size),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: numberPad(1, 10, size),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
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
    child: Text("Help [${sudoku.clues}]"),
  );
}

ElevatedButton errorButton() {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all((sudoku.error > 0)
          ? customColors.error
          : customColors.selectionTransparent),
    ),
    onPressed: () {},
    child: Text("Errors [${sudoku.error}]"),
  );
}

ElevatedButton exitButton(BuildContext context) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(customColors.green),
    ),
    onPressed: () {
      customRoutes.navigator(context, customRoutes.home);
    },
    child: const Text(" Home "),
  );
}

noteButton() {
  return FloatingActionButton(
    backgroundColor: (gameController.noteMode)
        ? customColors.green
        : customColors.blueTransparent,
    foregroundColor: customColors.white,
    onPressed: () {
      gameController.noteMode = !gameController.noteMode;
      gameController.update();
    },
    child: const Text("Note"),
  );
}
