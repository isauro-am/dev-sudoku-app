import 'dart:math';

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
  update() {
    setState(() {
      key++;
    });
  }

  @override
  Widget build(BuildContext context) {
    gameControl.gcUpdate = update;

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
              HomeButton(
                key: Key(
                  Random().nextInt(1000).toString(),
                ),
                draw: true,
              ),
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
              PadMenu(
                key: Key(Random().nextInt(1000).toString()),
              ),

              // Show message when the game is completed
              CompletedBoard(
                key: Key(Random().nextInt(1000).toString()),
              ),

              const SizedBox(
                height: 20,
              ),
              NumberPad(
                  key: Key(Random().nextInt(1000).toString()),
                  init: 1,
                  end: 10),
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
