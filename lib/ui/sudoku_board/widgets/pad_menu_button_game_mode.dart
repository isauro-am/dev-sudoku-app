

import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';

class GameModeButton extends StatelessWidget {
  const GameModeButton({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            (gameControl.noteMode)? Icons.draw : (gameControl.clues)? Icons.search :  Icons.gamepad_outlined,
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
}
