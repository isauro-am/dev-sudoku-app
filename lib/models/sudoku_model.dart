// To parse this JSON data, do
//
//     final sudoku = sudokuFromJson(jsonString);

import 'dart:convert';

import 'package:sudoku/models/sudoku_cell.dart';
import 'package:sudoku_api/sudoku_api.dart';

Sudoku sudokuFromJson(String str) => Sudoku.fromJson(json.decode(str));

String sudokuToJson(Sudoku data) => json.encode(data.toJson());


Sudoku sudokuBoard = Sudoku();

class Sudoku {
  Sudoku({
    this.points = 1000,
    this.error = 0,
    this.clues = 10,
    this.cells,
    // this.solution,
  });

  int points;
  int error;
  int clues;
  Map<String, SudokuCell>? cells;

  factory Sudoku.fromJson(Map<String, dynamic> json) => Sudoku(
        points: json["points"],
        error: json["error"],
        clues: json["clues"],
        cells: fromJsonCells(json["cells"]),
        // solution: fromJsonCells(json["solution"]),
      );

  Map<dynamic, dynamic> jsonCells(bool isSolution) {
    Map<dynamic, dynamic> matriz = {};
    Iterable<String>? keys = cells?.keys;
    // Iterable<String>? keys = (isSolution) ? solution?.keys : cells?.keys;
    for (String key in keys!) {
      matriz[key] = cells![key]?.toJson();
    }
    return matriz;
  }

  Map<String, dynamic> toJson() => {
        "points": points,
        "error": error,
        "clues": clues,
        "cells": jsonCells(false),
        // "solution": jsonCells(true),
      };

saveSudoku(Puzzle puzzle) {
  int x = 0;

  while (x < 9) {
    int y = 0;

    while (y < 9) {
      SudokuCell sc = SudokuCell();

      int? value;
      int? solution;

      value = puzzle.board()?.cellAt(Position(column: y, row: x)).getValue();
      solution =
          puzzle.solvedBoard()?.cellAt(Position(column: y, row: x)).getValue();

      value = (value == null) ? 0 : value;
      solution = (solution == null) ? 0 : solution;

      sc.value = value;
      sc.solution = solution;
      sc.bySystem = (value > 0) ? true : false;

      // if (isSolution) {
      //   sudoku.solution!["$x,$y"] = sc;
      // } else {
      cells!["$x,$y"] = sc;
      // }

      y++;
    }

    x++;
  }
}

setCells(Puzzle pluzze) {
  cells = {};
  saveSudoku(pluzze);
  // saveSudoku(pluzze, false);
}


}

Map<String, SudokuCell> fromJsonCells(Map<dynamic, dynamic> values) {
  Map<String, SudokuCell> array = {};
  Iterable keys = values.keys;
  for (String key in keys) {
    array[key] = SudokuCell.fromJson(values[key]);
  }
  return array;


  
}
