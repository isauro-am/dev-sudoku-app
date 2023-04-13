import 'package:flutter/material.dart';
import 'package:sudoku/domain/game_control.dart';

import '../../constants/colors.dart';
import 'widgets/draw_board.dart';
import 'widgets/home_button.dart';
import 'widgets/number_pad.dart';
import 'widgets/pad_menu.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({Key? key}) : super(key: key);

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  int key = 0;

  @override
  Widget build(BuildContext context) {
    update() {
      setState(() {
        key++;
      });
    }

    gameControl.update = update;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const HomeButton(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
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

              // Show message when the game is completed
              const CompletedBoard(),

              const SizedBox(
                height: 20,
              ),
              const NumberPad(init: 1, end: 10),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
