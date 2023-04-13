import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../constants/game_tags.dart';
import '../../../domain/game_control.dart';

class NotesButton extends StatelessWidget {
  const NotesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent,
      shadowColor: customColors.shadowColor,
      elevation: (gameControl.mode == gameTags.modeNotes)? 18: 0,
      child: Container(
        width: 70.w,
        height: 36.h,
        decoration: BoxDecoration(
          color: (gameControl.mode == gameTags.modeNotes)
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
            gameControl.setMode(gameTags.modeNotes);
            
          },
          child: Text(
            gameTags.modeNotes,
            style: TextStyle(
              color: customColors.primary,
              fontSize: 0.8.rem,
            ),
          ),
        ),
      ),
    );
  }
}
