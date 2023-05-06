import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/constants/game_tags.dart';

import '../../constants/colors.dart';
import 'bloc/sudoku_bloc.dart';
import 'draw_board.dart';
import 'number_pad.dart';
import 'widgets/end_game.dart';
import 'widgets/home_button.dart';
import 'widgets/pad_menu.dart';

class SudokuGame extends StatefulWidget {
  const SudokuGame({super.key});

  @override
  State<SudokuGame> createState() => _SudokuGameState();
}

class _SudokuGameState extends State<SudokuGame> {
  Widget content = Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/tiles_wallpaper/system.jpg'),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: customColors.primary,
            width: 3.0,
          ),
        ),
        child: const DrawPanel(),
      ),
      // Draw the pad menu
      const PadMenu(),

      const SizedBox(
        height: 10,
      ),
      const NumberPad(init: 1, end: 10),
    ],
  );

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
              const HomeButton(),
              const SizedBox(
                height: 20,
              ),
              BlocListener<SudokuBloc, SudokuState>(
                bloc: context.read<SudokuBloc>(),
                listener: (context, state) {
                  if (state is SudokuFailedState) {
                    content = Center(
                      child: Text(
                        'Failed',
                        style: TextStyle(
                          color: customColors.primary,
                          fontSize: 30,
                        ),
                      ),
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
