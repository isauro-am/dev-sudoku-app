import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/constants/game_tags.dart';
import 'package:sudoku/domain/sudoku_model.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/routes.dart';

class HomeButton extends StatelessWidget {
  final bool draw;
  const HomeButton({
    Key? key,
    required this.draw,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ((gameControl.completed ||
                (gameControl.completed ||
                    gameControl.errorLimit == sudokuBoard.error)) &&
            draw)
        ? const SizedBox(
            height: 30,
          )
        : Container(
            width: 80.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: customColors.bgByUser,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: customColors.primary,
                width: 2,
              ),
            ),
            child: TextButton(
              onPressed: () {
                gameControl.reset();

                customRoutes.navigator(context, customRoutes.home);
              },
              child: Text(
                gameTags.gcHome,
                style: TextStyle(color: customColors.primary),
              ),
            ),
          );
  }
}

class CompletedBoard extends StatelessWidget {
  const CompletedBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool display =
        (gameControl.completed || gameControl.errorLimit == sudokuBoard.error)
            ? true
            : false;

    String msg =
        (gameControl.completed) ? gameTags.msgSolved : gameTags.msgErrors;

    return (!display)
        ? const SizedBox()
        : Column(
            children: [
              Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26.h,
                  color: customColors.primary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const HomeButton(
                draw: false,
              ),
            ],
          );
  }
}
