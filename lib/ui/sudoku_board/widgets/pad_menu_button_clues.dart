import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/sudoku_model.dart';

class CluesButton extends StatelessWidget {


  const CluesButton({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}