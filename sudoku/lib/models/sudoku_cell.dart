import 'dart:convert';

SudokuCell sudokuCellFromJson(String str) =>
    SudokuCell.fromJson(json.decode(str));

String sudokuCellToJson(SudokuCell data) => json.encode(data.toJson());

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

  int value;
  int solution;
  int column;
  int row;
  bool bySystem;
  bool error;
  bool clue;
  bool hadNotes;
  List<String>? notes;

  factory SudokuCell.fromJson(Map<String, dynamic> json) => SudokuCell(
        value: json["value"],
        solution: json["solution"],
        column: json["column"],
        row: json["row"],
        bySystem: json["bySystem"],
        error: json["error"],
        clue: json["clue"],
        hadNotes: json["hadNotes"],
        notes: (null == json["notes"]) ? [] : json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "solution": solution,
        "column": column,
        "row": row,
        "bySystem": bySystem,
        "error": error,
        "clue": clue,
        "hadNotes": hadNotes,
        "notes": (null == notes) ? [] : notes,
      };
}
