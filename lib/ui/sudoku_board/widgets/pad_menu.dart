
import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/sudoku_model.dart';
import '../../../services/services.dart';

Material cluesButton() {
  return Material(
    elevation: (gameControl.clues) ? 5 : 0,
    shadowColor: customColors.blueLight,
    color: customColors.boardBlack,

    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              color: customColors.boardYellow,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        iconColor: MaterialStateProperty.all(customColors.boardYellow),
        backgroundColor: MaterialStateProperty.all(customColors.boardBlack),
      ),
      onPressed: () {
        if (gameControl.clues) {
          gameControl.clues = false;
          gameControl.selected = 0;
        } else {
          gameControl.selected = 0;
          gameControl.clues = true;
        }
        gameControl.update();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.help_center_outlined),
          const SizedBox(width: 5),
          CircleAvatar(
            
            backgroundColor: customColors.boardBlackSystem,
            radius: 12,
            child: Text(
              "${sudokuBoard.clues}",
              style: TextStyle(
                color: customColors.boardYellow,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

ElevatedButton errorButton() {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all((sudokuBoard.error > 0)
          ? customColors.error
          : customColors.selectionTransparent),
    ),
    onPressed: () {},
    child: Text("Errors [${sudokuBoard.error}]"),
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
    backgroundColor: (gameControl.noteMode)
        ? customColors.green
        : customColors.blueTransparent,
    foregroundColor: customColors.white,
    onPressed: () {
      gameControl.noteMode = !gameControl.noteMode;
      gameControl.update();
    },
    child: const Text("Note"),
  );
}


