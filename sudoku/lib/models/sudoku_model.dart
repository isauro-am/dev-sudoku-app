// To parse this JSON data, do
//
//     final sudoku = sudokuFromJson(jsonString);

import 'dart:convert';

import 'package:sudoku/models/sudoku_cell.dart';

Sudoku sudokuFromJson(String str) => Sudoku.fromJson(json.decode(str));

String sudokuToJson(Sudoku data) => json.encode(data.toJson());

class Sudoku {
  Sudoku({
    this.points = 1000,
    this.error = 0,
    this.clues = 10,
    this.cells,
    this.solution,
  });

  int points;
  int error;
  int clues;
  Map<String, SudokuCell>? cells;
  Map<String, SudokuCell>? solution;

  factory Sudoku.fromJson(Map<String, dynamic> json) => Sudoku(
        points: json["points"],
        error: json["error"],
        clues: json["clues"],
        cells: fromJsonCells(json["cells"]),
        solution: fromJsonCells(json["solution"]),
      );

  Map<dynamic, dynamic> jsonCells(bool isSolution) {
    Map<dynamic, dynamic> matriz = {};
    Iterable<String>? keys = (isSolution) ? solution?.keys : cells?.keys;
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
        "solution": jsonCells(true),
      };
}

Map<String, SudokuCell> fromJsonCells(Map<dynamic, dynamic> values) {
  Map<String, SudokuCell> array = {};
  Iterable keys = values.keys;
  for (String key in keys) {
    array[key] = SudokuCell.fromJson(values[key]);
  }
  return array;
}
