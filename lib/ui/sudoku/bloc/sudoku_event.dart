part of 'sudoku_bloc.dart';

@immutable
abstract class SudokuEvent {}

class SudokuInit extends SudokuEvent {}

class SudokuUserInteractionEvent extends SudokuEvent {
  final List<int> position;

  SudokuUserInteractionEvent({
    required this.position,
  });
}

class SudokuUserInteractionNoteEvent extends SudokuEvent {
  final List<int> position;
  final int note;

  SudokuUserInteractionNoteEvent({
    required this.position,
    required this.note,
  });
}

class SudokuUserInteractionSetValuesEvent extends SudokuEvent {
  final List<int> position;
  final int value;

  SudokuUserInteractionSetValuesEvent({
    required this.position,
    required this.value,
  });
}

class SudokuAwaitingInteractionEvent extends SudokuEvent {}

class SudokuUserInteractionSetNotesEvent extends SudokuEvent {
  final int value;
  final List<int> position;

  SudokuUserInteractionSetNotesEvent({
    required this.value,
    required this.position,
  });
}

class SudokuUserInteractionSetClueEvent extends SudokuEvent {
  final int value;
  final List<int> position;

  SudokuUserInteractionSetClueEvent({
    required this.value,
    required this.position,
  });
}

class SudokuCompletedEvent extends SudokuEvent {}

class SudokuFailedEvent extends SudokuEvent {}
