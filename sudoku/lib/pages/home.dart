import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

import '../models/models.dart';
import '../services/drawer.dart';
import '../services/services.dart';
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
        color: customColors.menu,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 500),
            decoration:  BoxDecoration(
              color: customColors.background,
              image: const DecorationImage(
                image: AssetImage("assets/menu.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: size.height,
            width: size.width,
            // color: customColors.background,
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
                    child: Center(child: Text("Start Game")),),
                  onPressed: () {
                    PuzzleOptions puzzleOptions = PuzzleOptions(
                      patternName: dificultController.patternName,
                      clues: dificultController.dificult,
                    );
                    Puzzle puzzle = Puzzle(puzzleOptions);
                    puzzle.generate().then(
                      (_) {
                        createSudoku(puzzle);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox jump(double value) {
  return SizedBox(
    height: value * 10,
  );
}

OutlinedButton dificultButton(int star, String text, Function update) {
  List<Widget> icons = [];
  List<int> clues = [40, 32, 24];
  int dificult = clues[star - 1];

  while (star > 0) {
    icons.add(
      Icon(
        Icons.star,
        size: 18,
        color: (dificultController.dificult == dificult)? customColors.yellow : customColors.yellowLight,
      ),
    );
    star--;
  }

  return OutlinedButton.icon(
    
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(10),
      backgroundColor: MaterialStateProperty.all(
          (dificultController.dificult == dificult)
              ? customColors.blueTransparent
              : customColors.blueLightTransparent ),
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