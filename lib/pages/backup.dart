


import 'package:flutter/material.dart';

import '../colors.dart';
import '../models/models.dart';
import '../services/services.dart';

List<Widget> dificult() {
  List<Widget> buttons = [];

  int lines = gameController.patternNames.length;

  lines = (lines ~/ 3);
  lines = lines + 1;

  int i = 0;
  int cicle = 0;
  while (i < lines) {
    buttons.add(
      Row(
        children: createFile(cicle),
      ),
    );
    i = i + 1;
    cicle = cicle + 3;
  }

  return buttons;
}



createFile(int cicle) {
  List<Widget> tmp = [];

  int limit = gameController.patternNames.length;
  if (cicle < limit) {
    tmp.add(buttonCreator(gameController.patternNames[cicle]));
  }

  if (cicle + 1 < limit) {
    tmp.add(buttonCreator(gameController.patternNames[cicle + 1]));
  }

  if (cicle + 2 < limit) {
    tmp.add(buttonCreator(gameController.patternNames[cicle + 2]));
  }
  return tmp;
}

buttonCreator(String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            (gameController.patternName == value)
                ? customColors.green
                : customColors.greenLight),
      ),
      onPressed: () {
        gameController.patternName = value;
        gameController.update();
      },
      child: Text(value),
    ),
  );
}

