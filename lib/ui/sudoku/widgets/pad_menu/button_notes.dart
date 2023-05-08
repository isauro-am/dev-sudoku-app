import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/domain/sudoku_model.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/game_tags.dart';

class NotesButton extends StatelessWidget {
  final Function update;

  const NotesButton({super.key, required this.update});

  @override
  Widget build(BuildContext context) {
    bool enabled = (sudokuBoard.mode == SudokuStatus.noteMode) ? true : false;

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
                  color: customColors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            iconColor: MaterialStateProperty.all(customColors.primary),
          ),
          onPressed: () {
            if (sudokuBoard.mode == SudokuStatus.noteMode) {
              sudokuBoard.mode = SudokuStatus.input;
            } else {
              sudokuBoard.mode = SudokuStatus.noteMode;
            }
            update();
          },
          child: Text(
            gameTags.note,
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
