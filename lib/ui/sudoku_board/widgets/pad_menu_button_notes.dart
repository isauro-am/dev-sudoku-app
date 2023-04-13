import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../constants/game_tags.dart';
import '../../../domain/game_control.dart';

class NotesButton extends StatelessWidget {
  const NotesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: customColors.bgByUser,
        shadowColor: customColors.shadowColor,
        elevation: (gameControl.mode == gameTags.modeNotes) ? 20 : 0,
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
