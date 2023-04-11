import 'package:flutter/material.dart';
import 'package:sudoku/domain/game_control.dart';
import 'package:sudoku/models/models.dart';

import '../../colors.dart';
import 'widgets/draw_board.dart';
import 'widgets/number_pad.dart';
import 'widgets/pad_menu.dart';

class SudokuBoard extends StatefulWidget {
  const SudokuBoard({Key? key}) : super(key: key);

  @override
  State<SudokuBoard> createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  @override
  Widget build(BuildContext context) {
    update() {
      setState(() {});
    }

    gameControl.update = update;

    return Scaffold(
      floatingActionButton: noteButton(),
      backgroundColor: customColors.boardBlack.withOpacity(0.5),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (gameController.completed) ? const SizedBox() : errorButton(),
                exitButton(context),
                (gameController.completed) ? const SizedBox() : cluesButton(),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10).copyWith(top: 0),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/tiles_wallpaper/system.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: customColors.boardYellow,
                  width: 3.0,
                ),
                // color: Colors.amberAccent,
                // image: const DecorationImage(
                //   image: AssetImage('assets/tiles_wallpaper/system.jpg'),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Column(
                children: drawPanel(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: numberPad(1, 10),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
