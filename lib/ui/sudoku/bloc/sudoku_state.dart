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
