import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/game_tags.dart';
import '../../../../domain/sudoku_model.dart';

class GameModeButton extends StatelessWidget {
  const GameModeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String mode = "${sudokuBoard.mode} ${gameTags.mode}";

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
            size: 0.9.rem,
            (sudokuBoard.mode == gameTags.modeNotes)
                ? Icons.draw
                : (sudokuBoard.mode == gameTags.modeClues)
                    ? Icons.search
                    : Icons.gamepad_outlined,
            color: customColors.primary,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(mode,
              style: TextStyle(
                color: customColors.primary,
                fontSize: 0.8.rem,
              )),
        ],
      ),
    );
  }
}
