import 'package:flutter/material.dart';
import 'package:sudoku/domain/sudoku_model.dart';

class SudokuCell {
  SudokuCell({
    this.value = 0,
    this.solution = 0,
    this.column = 0,
    this.row = 0,
    this.bySystem = false,
    this.error = false,
    this.hadNotes = false,
    this.notes,
  });

  VoidCallback onChange = () {};

  bool elevation = false;
  int value;
  int solution;
  int column;
  int row;
  bool bySystem;
  bool error;
  bool hadNotes;
  List<String>? notes;

  void needElevation() {
    if (int.parse(sudokuBoard.selected.split(',')[0]) == column ||
        int.parse(sudokuBoard.selected.split(',')[1]) == row) {
      elevation = true;
    } else {
      elevation = false;
    }
  }

  void addNote(int value) {
    notes ??= [];
    if (notes!.contains(value.toString())) {
      notes!.remove(value.toString());
    } else {
      notes!.add(value.toString());
    }
    hadNotes = true;

    if(notes!.length > 5){
      notes!.removeAt(0);
    }
  }

  String displayValue() {
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
