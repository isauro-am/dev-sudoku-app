part of 'sudoku_bloc.dart';

@immutable
abstract class SudokuState {
  final List<int> originalPosition = [9, 9];
  final int originalValue = 0;
}

class SudokuInitial extends SudokuState {
  final List<int> position = [9, 9];
  final int value = 0;

  @override
  List<int> get originalPosition => position;

  @override
  int get originalValue => value;
}

class SudokuAwaitingInteractionState extends SudokuState {
  final List<int> position;
  final int value;

  SudokuAwaitingInteractionState(this.position, this.value);
  @override
  List<int> get originalPosition => position;

  @override
  int get originalValue => value;
}

class SudokuUserInteractionState extends SudokuState {
  final List<int> position;
  final int value;
  SudokuUserInteractionState({
    required this.value,
    required this.position,
  });
  @override
  List<int> get originalPosition => position;

  @override
  int get originalValue => value;
}

class SudokuUserInteractionSetValuesState extends SudokuState {
  final List<int> position;
  final int value;
  SudokuUserInteractionSetValuesState({
    required this.value,
    required this.position,
  });
  @override
  List<int> get originalPosition => position;

  @override
  int get originalValue => value;
}

class SudokuUserInteractionSetNotesState extends SudokuState {
  final int value;
  final List<int> position;
  SudokuUserInteractionSetNotesState({
    required this.value,
    required this.position,
  });
  @override
  List<int> get originalPosition => position;

  @override
  int get originalValue => 0;
}

class SudokuUserInteractionSetClueState extends SudokuState {
  final List<int> position;
  final int value;
  SudokuUserInteractionSetClueState({
    required this.value,
    required this.position,
  });
  @override
  List<int> get originalPosition => position;

  @override
  int get originalValue => 0;
}

class SudokuCompletedState extends SudokuState {
  @override
  List<int> get originalPosition => [9, 9];

  @override
  int get originalValue => 0;
}
