import 'package:sudoku/domain/sudoku_model.dart';

class SudokuCell {
  SudokuCell({
    this.value = 0,
    this.solution = 0,
    this.column = 0,
    this.row = 0,
    this.bySystem = false,
    this.error = false,
    this.clue = false,
    this.hadNotes = false,
    this.notes,
  });

  bool elevation = false;
  int value;
  int solution;
  int column;
  int row;
  bool bySystem;
  bool error;
  bool clue;
  bool hadNotes;
  List<String>? notes;

  needElevation() {
    if (int.parse(sudokuBoard.selected.split(',')[0]) == column ||
        int.parse(sudokuBoard.selected.split(',')[1]) == row) {
      elevation = true;
    } else {
      elevation = false;
    }
  }

  displayValue() {
    if (hadNotes && notes != null && notes!.isNotEmpty) {
      return notes!.join('');
    } else {
      if (value == 0) {
        return '';
      } else {
        return value.toString();
      }
    }
  }
}
