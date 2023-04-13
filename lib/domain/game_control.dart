

import 'package:flutter/services.dart';

import '../constants/game_tags.dart';

GameControl gameControl = GameControl();

class GameControl {

  GameControl() {
    patternName = gameTags.gcRandom;
    completed = false;
    currentPos = [0, 0];
  }

  VoidCallback updateMenuPad = () {};
  VoidCallback updateMessage = () {};

  String mode = gameTags.modeInput;

  void setMode(String value){
    if(mode == value){
      mode = gameTags.modeInput;
    } else {
      mode = value;
    }
    gcUpdate();
  }


  VoidCallback gcUpdate = () {};

  int selected = 0;

  int dificult = 40;
  String patternName = gameTags.gcRandom;

  bool completed = false;

  List<int> currentPos = [10, 10];

  setPos(int x, int y) {
    currentPos[0] = x;
    currentPos[1] = x;
  }  
  
  List<int> currentRowCol = [10, 10];

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
