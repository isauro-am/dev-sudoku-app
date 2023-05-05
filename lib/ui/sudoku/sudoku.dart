import 'package:flutter/material.dart';

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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          key: const Key("BoardGame"),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: const [
              DrawPanel(),
              SizedBox(
                height: 10,
              ),
              PadMenu(),
              NumberPad(
                init: 1,
                end: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
