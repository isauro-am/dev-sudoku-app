import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'draw_board.dart';
import 'number_pad.dart';
import 'widgets/pad_menu.dart';

class SudokuGame extends StatefulWidget {
  const SudokuGame({super.key});

  @override
  State<SudokuGame> createState() => _SudokuGameState();
}

class _SudokuGameState extends State<SudokuGame> {
  @override
  Widget build(BuildContext context) {
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
              // HomeButton(
              //   key: Key(
              //     Random().nextInt(1000).toString(),
              //   ),
              //   draw: true,
              // ),
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
