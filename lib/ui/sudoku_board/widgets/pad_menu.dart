import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

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
          gameControl.noteMode = false;
          gameControl.clues = true;
        }
        gameControl.update();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.help_center_outlined),
          const SizedBox(
            width: 5,
            height: 30,
          ),
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

Container gameMode() {
  String mode = " Mode";

  if (gameControl.noteMode) {
    mode = "Note$mode";
  } else if (gameControl.clues) {
    mode = "Clues$mode";
  } else {
    mode = "Input$mode";
  }

  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 3,
    ),
    decoration: BoxDecoration(
      color: customColors.boardBlack,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: customColors.boardYellow,
        width: 2,
      ),
    ),
    child: Row(
      children: [
        Icon(
          Icons.gamepad_outlined,
          color: customColors.boardYellow,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(mode, style: TextStyle(color: customColors.boardYellow)),
      ],
    ),
  );
}

Container homeButton(BuildContext context) {
  return Container(
    width: 80.w,
    decoration: BoxDecoration(
      color: customColors.boardBlack,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: customColors.boardYellow,
        width: 2,
      ),
    ),
    child: TextButton(
      onPressed: () {
        customRoutes.navigator(context, customRoutes.home);
      },
      child: Text(
        " Home ",
        style: TextStyle(color: customColors.boardYellow),
      ),
    ),
  );
}

Container notesButton() {
  return Container(
    width: 70.w,
    height: 26.h,
    decoration: BoxDecoration(
      color: customColors.boardBlack,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: customColors.boardYellow,
        width: 2,
      ),
    ),
    child: TextButton(
      onPressed: () {
        gameControl.noteMode = !gameControl.noteMode;
        gameControl.clues = false;

        gameControl.update();
      },
      child: Text(
        "Notes",
        style: TextStyle(color: customColors.boardYellow),
      ),
    ),
  );
}
