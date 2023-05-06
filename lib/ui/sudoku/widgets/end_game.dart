import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../domain/sudoku_model.dart';
import 'home_button.dart';

class EndGame extends StatelessWidget {
  final String text;
  final int value;
  const EndGame({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Container(
        height: 75.mv,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: customColors.bgBySystem,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: customColors.primary,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: customColors.primary,
                      fontSize: 2.rem,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Score ${sudokuBoard.points}",
                        style: TextStyle(
                          color: customColors.primary,
                          fontSize: 1.rem,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Errors ${sudokuBoard.error}",
                        style: TextStyle(
                          color: customColors.primary,
                          fontSize: 1.rem,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const HomeButton(),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
