import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sudoku_event.dart';
part 'sudoku_state.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  SudokuBloc() : super(SudokuInitial()) {
    on<SudokuUserInteractionEvent>((event, emit) {
      emit(SudokuUserInteractionState(
        position: event.position,
        value: 0,
      ));
    });

    on<SudokuUserInteractionSetValuesEvent>((event, emit) {
      emit(SudokuUserInteractionSetValuesState(
        position: event.position,
        value: event.value,
      ));
    });

    on<SudokuUserInteractionSetNotesEvent>((event, emit) {
      emit(SudokuUserInteractionSetNotesState(
        position: event.position,
        value: event.value,
      ));
    });

    on<SudokuUserInteractionSetClueEvent>((event, emit) {
      emit(SudokuUserInteractionSetClueState(
        position: event.position,
        value: event.value,
      ));
    });

    on<SudokuCompletedEvent>((event, emit) {
      emit(SudokuCompletedState());
    });

    on<SudokuFailedEvent>((event, emit) {
      emit(SudokuFailedState());
    });
  }
}
