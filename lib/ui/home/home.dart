import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../../constants/colors.dart';
import '../../domain/game_control.dart';
import '../../domain/routes.dart';
import '../../domain/sudoku_model.dart';
import 'widgets/hard_level.dart';

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
    gameControl.gcUpdate = update;

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
              SelectHardLevel(stars: 1, update: update),
              const SizedBox(
                height: 20,
              ),
              SelectHardLevel(stars: 2, update: update),
              SizedBox(
                height: 20.h,
              ),
              SelectHardLevel(stars: 3, update: update),
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

