

GameControl gameControl = GameControl();

class GameControl {

  GameControl() {
    dificult = 40;
    patternName = "random";
    completed = false;
    noteMode = false;
    currentPos = [0, 0];
  }


  Function update = () {};

  int selected = 0;

  int dificult = 40;
  String patternName = "random";

  bool completed = false;
  bool noteMode = false;

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

  setDificult(int value) {
    dificult = value;
  }

  String getDificult(int dificult) {
    switch (dificult) {
      case 40:
        return "easy";
      case 32:
        return "medium";
      case 27:
        return "hard";
      default:
        return "unknown";
    }
  }
}
