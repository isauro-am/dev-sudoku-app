import 'package:flutter/material.dart';
import 'package:sudoku/domain/game_control.dart';

import '../../colors.dart';
import '../../domain/sudoku_model.dart';
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
              homeButton(context),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/tiles_wallpaper/system.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: customColors.boardYellow,
                    width: 3.0,
                  ),
                ),
                child: Column(
                  children: drawPanel(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (gameControl.completed) ? const SizedBox() : gameMode(),
                    (gameControl.completed) ? const SizedBox() : cluesButton(),
                    notesButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Errors:",
                          style: TextStyle(
                            color: customColors.boardYellow,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${sudokuBoard.error}",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: (sudokuBoard.error == 0)
                                ? customColors.boardYellow
                                : customColors.error,
                          ),
                        ),
                      ],
                    ),
                  ],
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
      ),
    );
  }
}
