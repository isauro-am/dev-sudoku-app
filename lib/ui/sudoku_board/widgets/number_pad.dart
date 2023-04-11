import 'package:flutter/material.dart';

import '../../../models/models.dart';
import '../../../services/services.dart';

Wrap numberPad(int init, int end, Size size) {
  double width = (size.width > 400) ? 360 / 9 : (size.width - 40) / 9;

  List<Widget> row = [];

  int number = 1 * init;

  while (number < end) {
    row.add(numberCell(number, width));
    number++;
  }

  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: row,
  );
}

InkWell numberCell(int n, double width) {
  return InkWell(
    onTap: () {
      gameController.selected = n;
      gameController.clues = false;
      gameController.update();
    },
    child: Material(
      elevation: (gameController.selected == n) ? 10 : 2,
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/buttons/dificult.jpeg"),
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
          border: Border.all(
            color: (gameController.selected == n)
                ? customColors.blueLight
                : customColors.white,
            width: (gameController.selected == n) ? 2 : 0,
          ),
        ),
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
    ),
  );
}