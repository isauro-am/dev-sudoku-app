import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../colors.dart';
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
    children: row,
  );
}

InkWell numberCell(int n) {
  return InkWell(
    onTap: () {
      gameControl.selected = n;
      // gameControl.clues = false;
      gameControl.update();
    },
    child: Material(
      elevation: (gameControl.selected == n) ? 15 : 2,
      shadowColor: customColors.boardYellow,
      child: Container(
        decoration: BoxDecoration(
          color: (gameControl.selected == n)
              ? customColors.boardBlack
              : customColors.boardBlackSystem,
          border: Border.all(
            color: (gameControl.selected == n)
                ? customColors.boardYellow
                : customColors.white,
            width: (gameControl.selected == n) ? 2 : 0,
          ),
        ),
        height: 40.h,
        width: 36.w,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                n.toString(),
                style: TextStyle(
                  color: customColors.boardYellow,
                  fontSize: (gameControl.selected == n) ? 14 : 20,
                ),
              ),
              (gameControl.selected == n)
                  ? Icon(
                      Icons.create_rounded,
                      color: customColors.boardYellow,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    ),
  );
}
