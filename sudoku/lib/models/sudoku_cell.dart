import 'dart:convert';

SudokuCell sudokuCellFromJson(String str) => SudokuCell.fromJson(json.decode(str));

String sudokuCellToJson(SudokuCell data) => json.encode(data.toJson());

class SudokuCell {
    SudokuCell({
        this.value = 0,
        this.column = 0,
        this.row = 0,
        this.bySystem = false,
        this.error = false,
        this.clue = false,
        this.hadNotes = false,
        this.notes,
    });

    int value;
    int column;
    int row;
    bool bySystem;
    bool error;
    bool clue;
    bool hadNotes;
    List<String>? notes;

    factory SudokuCell.fromJson(Map<String, dynamic> json) => SudokuCell(
        value: json["value"],
        column: json["column"],
        row: json["row"],
        bySystem: json["bySystem"],
        error: json["error"],
        clue: json["clue"],
        hadNotes: json["hadNotes"],
        notes: ( null == json["notes"])? [] : json["notes"],
    );


  // Map<dynamic, dynamic> jsonCells(bool isSolution) {
  //   Map<dynamic, dynamic> matriz = {};
  //   Iterable<String>? keys = (isSolution) ? solution?.keys : cells?.keys;
  //   for (String key in keys!) {
  //     matriz[key] = cells![key]?.toJson();
  //   }
  //   return matriz;
  // }
  
 Map<String, dynamic> toJson() => {
        "value": value,
        "column": column,
        "row": row,
        "bySystem": bySystem,
        "error": error,
        "clue": clue,
        "hadNotes": hadNotes,
        "notes": (null == notes)? [] : notes,
    };
}
