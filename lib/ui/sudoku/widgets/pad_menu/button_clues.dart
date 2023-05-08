import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/game_tags.dart';
import '../../../../domain/sudoku_model.dart';

class CluesButton extends StatelessWidget {
  final Function update;

  const CluesButton({super.key, required this.update});

  @override
  Widget build(BuildContext context) {
    bool enabled = (sudokuBoard.mode == SudokuStatus.clues) ? true : false;

    return SizedBox(
      width: 70.w,
      height: 36.h,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: customColors.bgByUser,
        shadowColor: customColors.shadowColor,
        elevation: enabled ? 20 : 0,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: (sudokuBoard.clues == 0)
                      ? customColors.primary.withOpacity(0.3)
                      : customColors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            iconColor: MaterialStateProperty.all(customColors.primary),
          ),
          onPressed: (sudokuBoard.clues == 0)
              ? null
              : () {
                  if (sudokuBoard.mode == SudokuStatus.clues) {
                    sudokuBoard.mode = SudokuStatus.input;
                  } else {
                    sudokuBoard.mode = SudokuStatus.clues;
                  }

                  update();
                },
          child: Text(
            gameTags.modeClues,
            textAlign: TextAlign.center,
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
