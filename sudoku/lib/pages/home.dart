import 'package:flutter/material.dart';
import 'package:sudoku/pages/services/services.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../models/models.dart';
import 'services/drawer.dart';
import 'utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    update() {
      setState(() {});
    }

    dificultController.update = update;

    return Scaffold(
      appBar: customAppBar(true, "Sudoku"),
      body: Container(
        height: size.height,
        width: size.width,
        color: customColors.background,
        child: Column(
          children: [
            jump(3),
            dificultButton(1, "Easy", update),
            jump(2),
            dificultButton(2, "Medium", update),
            jump(2),
            dificultButton(3, "Hard", update),
            jump(2),
            Center(
              child: ElevatedButton(
                child: const Text("Start Game"),
                onPressed: () {
                  PuzzleOptions puzzleOptions = PuzzleOptions(
                    patternName: dificultController.patternName,
                    clues: dificultController.dificult,
                  );
                  Puzzle puzzle = Puzzle(puzzleOptions);
                  puzzle.generate().then(
                    (_) {
                      createSudoku(puzzle);
                      print(sudoku.toJson());
                      print("");
                      printGrid(puzzle.board());

                      // print("=====================================");
                      // print("Your puzzle, fresh off the press:");
                      // print("-------------------------------------");

                      // print(puzzle.board()?.cellAt(Position(column: 1, row: 1)).getValue());
                      // print("=====================================");
                      // print(puzzle.solvedBoard()?.cellAt(Position(column: 1, row: 1)).getValue());
                      // print("Give up? Here's your puzzle solution:");
                      // print("-------------------------------------");
                      // printGrid(puzzle.solvedBoard());
                      // print("=====================================");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

jump(double value) {
  return SizedBox(
    height: value * 10,
  );
}

dificultButton(int star, String text, Function update) {
  List<Widget> icons = [];
  List<int> clues = [40, 32, 24];
  int dificult = clues[star - 1];

  while (star > 0) {
    icons.add(
      const Icon(
        Icons.star,
        size: 18,
        color: Colors.yellow,
      ),
    );
    star--;
  }

  return OutlinedButton.icon(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(15),
      backgroundColor: MaterialStateProperty.all(
          (dificultController.dificult == dificult)
              ? customColors.green
              : customColors.greenLight),
    ),
    onPressed: () {
      dificultController.dificult = dificult;
      update();
    },
    icon: SizedBox(
      width: 60,
      child: Row(
        children: icons,
      ),
    ),
    label: Container(
      alignment: Alignment.centerRight,
      width: 90,
      height: 50,
      child: Text(
        text,
        style: TextStyle(
          color: customColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

// dificultButtons(context, size, 'Facil', 'template', 40),
//               dificultButtons(context, size, 'Medio', 'template', 28),
//               dificultButtons(context, size, 'Dificil', 'template', 18),

  //   _l.add(new MY.Pattern("random", null));

  //   _l.add(new MY.Pattern("spring", _spring, clues: 29));
  //   _l.add(new MY.Pattern("summer", _summer, clues: 27));
  //   _l.add(new MY.Pattern("fall", _fall, clues: 24));
  //   _l.add(new MY.Pattern("winter", _winter, clues: 31));
  // }