import 'package:flutter/services.dart';

import '../constants/game_tags.dart';

GameControl gameControl = GameControl();

class GameControl {
  VoidCallback gcUpdate = () {};

  int selected = 0;
  int dificult = 40;
  int cluesLimit = 80;
  int errorLimit = -1; // -1 = unlimited

  bool completed = false;

  String mode = gameTags.modeInput;
  String patternName = gameTags.gcRandom;

  List<int> currentPos = [9, 9];
  List<int> currentRowCol = [9, 9];

  String currentSelected = "9,9";
  String oldSelection = "9,9";

  void setSelection(String value) {
    oldSelection = currentSelected;
    currentSelected = value;
  }

  void reset() {
    currentPos = [9, 9];
    currentRowCol = [9, 9];
    selected = 0;
    dificult = 40;
    completed = false;
    mode = gameTags.modeInput;
    patternName = gameTags.gcRandom;
    gcUpdate = () {};
  }

  void setMode(String value) {
    if (mode == value) {
      mode = gameTags.modeInput;
    } else {
      mode = value;
    }
    gcUpdate();
  }

  setPos(int x, int y) {
    currentPos[0] = x;
    currentPos[1] = x;
  }

  setRowCol(int x, int y) {
    currentRowCol[0] = x;
    currentRowCol[1] = x;
  }

  String getDificult(value) {
    switch (value) {
      case 40:
        return gameTags.gcEasy;
      case 32:
        return gameTags.gcMedium;
      case 24:
        return gameTags.gcHard;
      default:
        return gameTags.gcUnknown;
    }
  }
}
