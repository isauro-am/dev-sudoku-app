class Dificult {

  Function update = (){};

  List<String> patternNames = [
    'random',
    'spring',
    'summer',
    'fall',
    'winter',
  ];

  Map<String, int> dificults = {
    "easy":40,
    "medium":32,
    "hard":27,
  };

  int dificult = 40;
  String patternName = "random";

  int selected = 0;

  bool completed = false;

  bool clues = true;

  int currentCol = 10;
  int currentRow = 10;

  matchColRow(int x, int y){
    int coincidence = 0;
    if(currentRow == x){
     coincidence++;
    }
    if(currentCol == y){
     coincidence++;
    }
    return coincidence;
  }

  setXY(int x, int y){
    currentCol = y;
    currentRow = x;
  }


}



  //   _l.add(new MY.Pattern("spring", _spring, clues: 29));
  //   _l.add(new MY.Pattern("summer", _summer, clues: 27));
  //   _l.add(new MY.Pattern("fall", _fall, clues: 24));
  //   _l.add(new MY.Pattern("winter", _winter, clues: 31));