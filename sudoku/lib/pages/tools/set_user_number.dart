

import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../services/services.dart';

Row userNumberTools(int init, int end, Size size) {
  double width = (size.width > 400) ? 360 / 6 : (size.width - 40) / 6;

  List<Widget> row = [];

  int number = 1 * init;

  while (number < end) {
    row.add(numberSet(number, width));
    number++;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: row,
  );
}

InkWell numberSet(int n, double width) {
  return InkWell(
    onTap: () {
      gameController.selected = n;
      gameController.clues = false;
      gameController.update();
    },
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: customColors.blueLightTransparent,
          ),
          color: (gameController.selected == n)
              ? customColors.selectionAlfa
              : customColors.selectionTransparent,
          borderRadius: const BorderRadius.all(Radius.circular(3))),
      height: width,
      width: width,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              n.toString(),
              style: TextStyle(
                fontSize: (gameController.selected == n) ? 14 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            (gameController.selected == n)
                ? const Icon(Icons.create_rounded)
                : const SizedBox(),
          ],
        ),
      ),
    ),
  );
}
