import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/routes.dart';
import '../../../domain/sudoku_model.dart';

Container cluesButton() {
  return Container(
    height: 36.h,
    decoration: BoxDecoration(
      color: (gameControl.clues)
          ? customColors.white.withOpacity(0.1)
          : customColors.bgByUser,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(
              color: customColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        iconColor: MaterialStateProperty.all(customColors.primary),
      ),
      onPressed: () {
        if (gameControl.clues) {
          gameControl.clues = false;
        } else {
          gameControl.noteMode = false;
          if (sudokuBoard.clues > 0) {
            gameControl.clues = true;
          }
        }
        gameControl.update();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Clues",
            style: TextStyle(color: customColors.primary),
          ),
          const SizedBox(
            width: 5,
            height: 30,
          ),
          CircleAvatar(
            backgroundColor: customColors.bgBySystem,
            radius: 12,
            child: Text(
              "${sudokuBoard.clues}",
              style: TextStyle(
                color: customColors.primary,
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
    height: 36.h,
    padding: const EdgeInsets.symmetric(
      horizontal: 3,
    ),
    decoration: BoxDecoration(
      color: customColors.bgByUser,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: customColors.primary,
        width: 2,
      ),
    ),
    child: Row(
      children: [
        Icon(
          Icons.gamepad_outlined,
          color: customColors.primary,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(mode, style: TextStyle(color: customColors.primary)),
      ],
    ),
  );
}

Container homeButton(BuildContext context) {
  return Container(
    width: 80.w,
    height: 36.h,
    decoration: BoxDecoration(
      color: customColors.bgByUser,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: customColors.primary,
        width: 2,
      ),
    ),
    child: TextButton(
      onPressed: () {
        gameControl = GameControl();

        customRoutes.navigator(context, customRoutes.home);
      },
      child: Text(
        " Home ",
        style: TextStyle(color: customColors.primary),
      ),
    ),
  );
}

Container notesButton() {
  return Container(
    width: 70.w,
    height: 36.h,
    decoration: BoxDecoration(
      color: (gameControl.noteMode)
          ? customColors.white.withOpacity(0.1)
          : customColors.bgByUser,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: customColors.primary,
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
        style: TextStyle(color: customColors.primary),
      ),
    ),
  );
}
