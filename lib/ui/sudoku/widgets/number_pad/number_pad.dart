import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';

import '../../../../../constants/colors.dart';
import '../../../../../domain/sudoku_model.dart';
import '../../bloc/sudoku_bloc.dart';

class NumberPad extends StatelessWidget {
  final int init;
  final int end;

  const NumberPad({
    Key? key,
    required this.init,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> row = [];

    int number = 1 * init;

    while (number < end) {
      row.add(NumberCell(number: number));
      number++;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25)
          .copyWith(top: 10),
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: row,
        ),
      ),
    );
  }
}

class NumberCell extends StatelessWidget {
  final int number;

  const NumberCell({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customColors.bgBySystem,
        border: Border.all(
          color: customColors.white,
          width: 1,
        ),
      ),
      height: 44.h,
      width: 36.w,
      child: Center(
        child: TextButton(
          onPressed: sudokuBoard.completed
              ? null
              : () {
                  if (sudokuBoard.mode == SudokuStatus.noteMode) {
                    context.read<SudokuBloc>().add(
                          SudokuUserInteractionSetNotesEvent(
                              position: context
                                  .read<SudokuBloc>()
                                  .state
                                  .originalPosition,
                              value: number),
                        );
                  } else {
                    context.read<SudokuBloc>().add(
                          SudokuUserInteractionSetValuesEvent(
                              position: context
                                  .read<SudokuBloc>()
                                  .state
                                  .originalPosition,
                              value: number),
                        );
                  }
                },
          child: Text(
            number.toString(),
            style: TextStyle(
              color: customColors.primary,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
