import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/constants/game_tags.dart';
import 'package:sudoku/domain/sudoku_model.dart';

import 'bloc/sudoku_bloc.dart';
import 'widgets/views/board.dart';
import 'widgets/views/end_game.dart';

class SudokuGame extends StatefulWidget {
  const SudokuGame({super.key});

  @override
  State<SudokuGame> createState() => _SudokuGameState();
}

class _SudokuGameState extends State<SudokuGame> {
  Widget content = const BoardGame();

  @override
  Widget build(BuildContext context) {
    update() {
      setState(() {});
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tiles_wallpaper/user.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              BlocListener<SudokuBloc, SudokuState>(
                bloc: context.read<SudokuBloc>(),
                listener: (context, state) {
                  if (state is SudokuFailedState) {
                    content = EndGame(
                      text: (sudokuBoard.points == 0)
                          ? gameTags.msgScore
                          : gameTags.msgErrors,
                      value: 0,
                    );
                    update();
                  }
                  if (state is SudokuCompletedState) {
                    content = EndGame(
                      text: gameTags.msgSolved,
                      value: 0,
                    );
                    update();
                  }
                },
                child: const SizedBox(),
              ),
              content
            ],
          ),
        ),
      ),
    );
  }
}
