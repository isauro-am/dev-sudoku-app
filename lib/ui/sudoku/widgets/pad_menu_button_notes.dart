import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/domain/sudoku_model.dart';

import '../../../constants/colors.dart';
import '../../../constants/game_tags.dart';

class NotesButton extends StatefulWidget {
  final Function update;

  const NotesButton({Key? key, required this.update}) : super(key: key);

  @override
  State<NotesButton> createState() => _NotesButtonState();
}

class _NotesButtonState extends State<NotesButton> {
  String current = "";

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
            current = sudokuBoard.mode;

            widget.update();
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
