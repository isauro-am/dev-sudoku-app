import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/domain/sudoku_model.dart';
import 'package:sudoku/ui/sudoku/bloc/sudoku_bloc.dart';

import '../../constants/colors.dart';

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

    return Material(
      shadowColor: customColors.shadowColor,
      elevation: selected ? 15 : 0,
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

                setState(() {});
              }

              if (state is SudokuUserInteractionSetValuesState) {
                if (state.position == widget.position) {
                  sudokuBoard.values![strPosition] = state.value;
                }

                setState(() {});
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
                    ? 3
                    : 0,
                color: customColors.shadowColor,
              ),
              color: cellColor(
                selected,
                error,
                bySystem,
              ),
            ),
            width: 10.1.vw,
            height: 45.h,
            child: TextButton(
              onPressed: () {
                context
                    .read<SudokuBloc>()
                    .add(SudokuUserInteractionEvent(position: widget.position));

                setState(() {});
              },
              child: Text(
                (value > 0) ? "$value" : "",
                // sudokuCell.displayValue(),
                style: TextStyle(
                  color:
                      selected ? customColors.bgBySystem : customColors.primary,
                  // color: colors[2],
                  fontSize: 1.2.rem,
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

Color cellColor(bool selected, bool error, bool bySystem) {
  if (selected && !error) {
    return customColors.selectedRow;
  } else if (error) {
    return customColors.error;
  } else if (!bySystem) {
    return customColors.bgBySystem;
  } else {
    return customColors.bgByUser;
  }
}

bool crossSelection(List<int> selected, List<int> cell) {
  if (selected[0] == cell[0] || selected[1] == cell[1]) {
    return true;
  } else if (selected[0] ~/ 3 == cell[0] ~/ 3 &&
      selected[1] ~/ 3 == cell[1] ~/ 3) {
    return true;
  } else {
    return false;
  }
}

bool crossSelectionError(List<int> cell, int value) {
  return false;
}
