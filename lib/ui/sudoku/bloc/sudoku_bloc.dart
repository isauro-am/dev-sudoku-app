import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sudoku_event.dart';
part 'sudoku_state.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  SudokuBloc() : super(SudokuInitial()) {
    on<SudokuUserInteractionEvent>((event, emit) {
      print("here");

      emit(SudokuUserInteractionState(position: event.position, value: 0));

      // Future.delayed(const Duration(milliseconds: 100), () {
      //   emit(SudokuAwaitingInteractionState());
      // });
    });

    on<SudokuUserInteractionSetValuesEvent>((event, emit) {
      emit(SudokuUserInteractionSetValuesState(
        position: event.position,
        value: event.value,
      ));
    });

    on<SudokuUserInteractionSetNotesEvent>((event, emit) {
      emit(SudokuUserInteractionSetNotesState(
        position: event.position, value: event.value,
      ));
    });
  }
}
