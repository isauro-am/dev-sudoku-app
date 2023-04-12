import '../domain/sudoku_model.dart';

checkAllPad() {
  removeErrorBySystem();
  int x = 0;
  while (x < 9) {
    int y = 0;
    while (y < 9) {
      if (sudokuBoard.cells!['$x,$y']!.value != 0) {
        findRowValue(x, y, sudokuBoard.cells!['$x,$y']!.value);
        findColumnValue(x, y, sudokuBoard.cells!['$x,$y']!.value);
        findInSector(x, y, sudokuBoard.cells!['$x,$y']!.value);
      } else {
        sudokuBoard.cells!['$x,$y']!.error = false;
      }

      y++;
    }
    x++;
  }
}

removeErrorBySystem() {
  int x = 0;
  while (x < 9) {
    int y = 0;
    while (y < 9) {
      if (sudokuBoard.cells!['$x,$y']!.bySystem) {
        sudokuBoard.cells!['$x,$y']!.error = false;
      }
      y++;
    }
    x++;
  }
}

findRowValue(int x, int y, int value) {
  int yy = 0;
  while (yy < 9) {
    if (sudokuBoard.cells!['$x,$yy']!.value == value) {
      if (y != yy) {
        sudokuBoard.cells!['$x,$yy']!.error = true;
      }
    }
    yy++;
  }
}

findColumnValue(int x, int y, int value) {
  int xx = 0;
  while (xx < 9) {
    if (sudokuBoard.cells!['$xx,$y']!.value == value) {
      if (x != xx) {
        sudokuBoard.cells!['$xx,$y']!.error = true;
      }
    }
    xx++;
  }
}

getSectorXY(int x, int y) {
  int sectorX = 0;
  int sectorY = 0;

  if (x < 3) {
    sectorX = 0;
  } else if (x < 6) {
    sectorX = 3;
  } else {
    sectorX = 6;
  }

  if (y < 3) {
    sectorY = 0;
  } else if (y < 6) {
    sectorY = 3;
  } else {
    sectorY = 6;
  }

  return [sectorX, sectorY];
}

findInSector(int x, int y, int value) {
  List<int> sectorXY = getSectorXY(x, y);
  int sectorX = sectorXY[0];
  int sectorY = sectorXY[1];

  int xx = sectorX;
  while (xx < sectorX + 3) {
    int yy = sectorY;
    while (yy < sectorY + 3) {
      if (sudokuBoard.cells!['$xx,$yy']!.value == value) {
        if (x != xx && y != yy) {
          sudokuBoard.cells!['$xx,$yy']!.error = true;
        }
      }
      yy++;
    }
    xx++;
  }
}
