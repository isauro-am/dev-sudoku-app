import 'package:flutter/material.dart';
import 'package:sudoku/models/dificult.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../colors.dart';
import '../domain/sudoku_model.dart';
import '../models/models.dart';
import '../pages/template_page.dart';
import '../pages/utils.dart';
import '../services/services.dart';

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

    gameController.update = update;

    return CustomPageTemplate(
      appBar: false,
      background: "assets/wallpaper/wallpaper.jpg",
      size: size,
      color: customColors.green,
      title: "Sudoku",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          jump(3),
          dificultButton(1, "Easy", update),
          jump(2),
          dificultButton(2, "Medium", update),
          jump(2),
          dificultButton(3, "Hard", update),
          jump(6),
          ElevatedButton(
            child: const SizedBox(
              height: 30,
              width: 120,
              child: Center(child: Text("Start Game")),
            ),
            onPressed: () {
              PuzzleOptions puzzleOptions = PuzzleOptions(
                patternName: gameController.patternName,
                clues: gameController.dificult,
              );
              Puzzle puzzle = Puzzle(puzzleOptions);
              puzzle.generate().then(
                (_) {
                  sudoku = Sudoku();
                  createSudoku(puzzle);
                  gameController = Dificult();
                  customRoutes.navigator(context, customRoutes.game);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

SizedBox jump(double value) {
  return SizedBox(
    height: value * 10,
  );
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
        padding: const EdgeInsets.only(left:2.0),
        child: Image.asset("assets/icons/star.png", width: 20, height: 20),
      )
    );
    star--;
  }

  return Container(

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: customColors.blueLightTransparent,
    ),
    constraints: const BoxConstraints(
      maxWidth: 200,
    ),

    child: OutlinedButton.icon(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(10),
        backgroundColor: MaterialStateProperty.all(
            (gameController.dificult == dificult)
                ? customColors.blueTransparent
                : customColors.blueLightTransparent),
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
            color: customColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}

