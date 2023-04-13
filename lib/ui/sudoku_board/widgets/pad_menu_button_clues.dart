import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../constants/game_tags.dart';
import '../../../domain/game_control.dart';
import '../../../domain/sudoku_model.dart';

class CluesButton extends StatelessWidget {
  const CluesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: customColors.bgByUser,
        shadowColor: customColors.shadowColor,
        elevation: (gameControl.mode == gameTags.modeClues) ? 20 : 0,
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
          onPressed: (sudokuBoard.clues < 1)
              ? () {}
              : () {
                  gameControl.setMode(gameTags.modeClues);
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gameTags.modeClues,
                style: TextStyle(
                  color: customColors.primary,
                  fontSize: 0.8.rem,
                ),
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
      ),
    );
  }
}
