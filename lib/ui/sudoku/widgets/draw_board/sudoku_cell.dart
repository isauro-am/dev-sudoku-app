import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/domain/sudoku_model.dart';
import 'package:sudoku/ui/sudoku/bloc/sudoku_bloc.dart';

import '../../../../constants/colors.dart';
import '../utils.dart';

class SudokuCellBox extends StatefulWidget {
  final List<int> position;

  const SudokuCellBox({
    super.key,
    required this.position,
  });

  @override
  State<SudokuCellBox> createState() => _SudokuCellBoxState();
}

class _SudokuCellBoxState extends State<SudokuCellBox> {
  bool selected = false;
  bool bySystem = false;
  int solution = 0;
  bool error = false;
  List<int> notes = [];
  int value = 0;

  @override
  Widget build(BuildContext context) {
    String strPosition = '${widget.position[0]},${widget.position[1]}';

    value = sudokuBoard.values![strPosition] ?? 0;
    solution = sudokuBoard.solved![strPosition] ?? 0;
    bySystem = sudokuBoard.bySystem![strPosition] ?? false;

    error = crossSelectionError(widget.position, value);

    update() {
      sudokuBoard.isCompleted(context);
      setState(() {});
    }

    return Material(
      shadowColor: customColors.shadowColor,
      elevation: selected ? 10 : 0,
      child: Column(
        children: [
          BlocListener<SudokuBloc, SudokuState>(
            bloc: context.read<SudokuBloc>(),
            listener: (context, state) {
              if (state is SudokuUserInteractionState) {
                if (state.position == widget.position) {
                  selected = true;
                } else {
                  selected = false;
                }
                update();
              }

              if (state is SudokuUserInteractionSetValuesState) {
                if (state.position == widget.position && !bySystem) {
                  if (state.value == value) {
                    context.read<SudokuBloc>().add(
                          SudokuUserInteractionSetValuesEvent(
                              position: context
                                  .read<SudokuBloc>()
                                  .state
                                  .originalPosition,
                              value: 0),
                        );
                  } else {
                    sudokuBoard.values![strPosition] = state.value;
                    value = state.value;
                    if (crossSelectionError(widget.position, value)) {
                      sudokuBoard.error++;
                      sudokuBoard.points = sudokuBoard.points -
                          (Random().nextInt(10 - 4 + 1) + 4);
                      if (sudokuBoard.points < 0 || sudokuBoard.points == 0) {
                        sudokuBoard.points = 0;
                        context.read<SudokuBloc>().add(
                              SudokuFailedEvent(),
                            );
                      }
                    }
                    notes = [];
                  }
                }
                update();
              }

              if (state is SudokuUserInteractionSetNotesState) {
                if (state.position == widget.position && !bySystem) {
                  sudokuBoard.values![strPosition] = 0;
                  if (notes.contains(state.value)) {
                    notes.remove(state.value);
                  } else {
                    notes.add(state.value);
                    (notes.length > 5) ? notes.removeAt(0) : null;
                  }
                }
                update();
              }

              if (state is SudokuUserInteractionSetClueState) {
                if (state.position == widget.position) {
                  sudokuBoard.values![strPosition] =
                      sudokuBoard.solved![strPosition]!;
                  value = sudokuBoard.solved![strPosition]!;
                  notes = [];
                }
                update();
              }
            },
            child: const SizedBox(),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: (crossSelection(
                        context.read<SudokuBloc>().state.originalPosition,
                        widget.position))
                    ? 2
                    : 0,
                color: customColors.shadowColor,
              ),
              color: cellColor(selected, error, bySystem),
            ),
            width: 10.1.vw,
            height: 45.h,
            child: TextButton(
              onPressed: sudokuBoard.completed
                  ? null
                  : () {
                      if (sudokuBoard.mode == SudokuStatus.clues &&
                          !bySystem &&
                          sudokuBoard.clues > 0) {
                        context.read<SudokuBloc>().add(
                              SudokuUserInteractionSetClueEvent(
                                  position: widget.position, value: 0),
                            );
                        sudokuBoard.bySystem![strPosition] = true;
                        sudokuBoard.clues--;
                      }

                      context.read<SudokuBloc>().add(SudokuUserInteractionEvent(
                          position: widget.position));

                      setState(() {});
                    },
              child: Text(
                (notes.isNotEmpty)
                    ? notes.join(",")
                    : (value > 0)
                        ? "$value"
                        : "",
                style: TextStyle(
                  color:
                      selected ? customColors.bgBySystem : customColors.primary,
                  fontSize: notes.isNotEmpty ? 0.7.rem : 1.2.rem,
                  fontWeight: (bySystem) ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
