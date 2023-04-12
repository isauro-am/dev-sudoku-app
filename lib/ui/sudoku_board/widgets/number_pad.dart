import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../colors.dart';
import '../../../data/set_value_sudokucell.dart';
import '../../../domain/game_control.dart';

Wrap numberPad(int init, int end) {
  List<Widget> row = [];

  int number = 1 * init;

  while (number < end) {
    row.add(numberCell(number));
    number++;
  }

  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: (gameControl.completed)? [] : row,
  );
}

Container numberCell(int number) {
  return Container(
    decoration: BoxDecoration(
      color: customColors.boardBlackSystem,
      border: Border.all(
        color: customColors.white,
        width: 1,
      ),
    ),
    height: 40.h,
    width: 36.w,
    child: Center(
      child: TextButton(
        onPressed: () {
          // Disable clues
          gameControl.clues = false;

          // Set selected number or note
          setSudokuCellValues(number);
          sleep(
            const Duration(
              milliseconds: 100,
            ),
          );
          gameControl.update();
        },
        child: Text(
          number.toString(),
          style: TextStyle(
            color: customColors.boardYellow,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
