import 'package:flutter/material.dart';
import 'package:sudoku/models/models.dart';
import 'package:sudoku/ui/home.dart';
import 'package:sudoku/services/services.dart';

import 'tools/drow_template.dart';
import 'template_page.dart';
import 'tools/set_user_number.dart';

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
      actionButton: noteButton(),
      appBar: false,
      background: "assets/game.png",
      size: size,
      title: "Sudoku",
      color: customColors.inputBorder,
      child: SingleChildScrollView(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: drawPanel(size),
            ),
            jump(2),
            userNumberTools(1, 5, size),
            userNumberTools(5, 10, size),
            jump(1),
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
    backgroundColor: (gameController.noteMode)? customColors.green :customColors.blueTransparent,
    foregroundColor: customColors.white,
    onPressed: () {
      gameController.noteMode = !gameController.noteMode;
      gameController.update();
    },
    child: const Text("Note"),
    // child: const Icon(Icons.note_add),
  );
}
