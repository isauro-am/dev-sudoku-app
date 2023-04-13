

import 'package:flutter/services.dart';

GameControl gameControl = GameControl();

class GameControl {

  GameControl() {
    patternName = "random";
    completed = false;
    currentPos = [0, 0];
  }

  VoidCallback updateMenuPad = () {};
  VoidCallback updateMessage = () {};

  String mode = "Input";

  setMode(String value){
    if(mode == value){
      mode = "Input";
    } else {
      mode = value;
    }
  }


  VoidCallback update = () {};

  int selected = 0;

  int dificult = 40;
  String patternName = "random";

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
        return "Easy";
      case 32:
        return "Medium";
      case 24:
        return "Hard";
      default:
        return "unknown";
    }
  }
}
