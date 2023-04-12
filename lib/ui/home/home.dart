import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../colors.dart';
import '../domain/game_control.dart';
import '../domain/sudoku_model.dart';
import '../services/routes.dart';
import 'hard_level.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            image: AssetImage('assets/wallpaper/wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectHardLevel(1, "Easy", update),
              const SizedBox(
                height: 20,
              ),
              selectHardLevel(2, "Medium", update),
              SizedBox(
                height: 20.h,
              ),
              selectHardLevel(3, "Hard", update),
              const SizedBox(
                height: 60,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: customColors.white,
                    width: 2.0,
                  ),
                  color: Colors.amberAccent,
                  image: const DecorationImage(
                    image: AssetImage('assets/tiles_wallpaper/system.jpg'),
                    fit: BoxFit.cover,
                    opacity: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),

                  // color: customColors.blueLightTransparent,
                ),
                constraints: const BoxConstraints(maxWidth: 250, minWidth: 180),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(50),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: const Text("Start Game"),
                  onPressed: () {
                    // Create a new puzzle with the selected dificult
                    Puzzle puzzle = Puzzle(
                      PuzzleOptions(
                        patternName: gameControl.patternName,
                        clues: gameControl.dificult,
                      ),
                    );

                    puzzle.generate().then(
                      (_) {
                        // Reset instance of the sudoku board
                        sudokuBoard = Sudoku();

                        sudokuBoard.setRowColumns(puzzle);

                        // Navigate to the game screen
                        customRoutes.navigator(context, customRoutes.game);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

