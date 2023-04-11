import 'package:flutter/material.dart';
import 'package:sudoku/ui/sudoku_board/sudoku_board.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../colors.dart';
import '../domain/game_control.dart';
import '../models/models.dart';
import '../domain/sudoku_model.dart';

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

    gameController.update = update;

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
              dificultButton(1, "Easy", update),
              const SizedBox(
                height: 20,
              ),
              dificultButton(2, "Medium", update),
              const SizedBox(
                height: 20,
              ),
              dificultButton(3, "Hard", update),
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

                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const SudokuBoard(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
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

Container dificultButton(int star, String text, Function update) {
  // Set the number of stars
  List<Widget> icons = [];

  // Set the number of clues
  List<int> clues = [40, 32, 24];
  int dificult = clues[star - 1];

  while (star > 0) {
    icons.add(
      Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Image.asset(
          "assets/icons/star.png",
          width: 20,
          height: 20,
        ),
      ),
    );
    star--;
  }

  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: const AssetImage('assets/buttons/dificult.jpeg'),
        fit: BoxFit.cover,
        opacity: (gameController.dificult == dificult) ? 1 : 0.4,
      ),
      borderRadius: BorderRadius.circular(10),
      // color: customColors.blueLightTransparent,
    ),
    constraints: const BoxConstraints(
      maxWidth: 250,
    ),
    child: OutlinedButton.icon(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(
            (gameController.dificult == dificult) ? 30 : 1),
      ),
      onPressed: () {
        gameController.dificult = dificult;
        update();
      },
      icon: Row(
        children: icons,
      ),
      label: Container(
        alignment: Alignment.centerRight,
        height: 50,
        child: Text(
          text,
          style: TextStyle(
              color: customColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              overflow: TextOverflow.ellipsis),
        ),
      ),
    ),
  );
}
