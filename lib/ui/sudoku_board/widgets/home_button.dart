import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/routes.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (gameControl.completed)
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
                gameControl = GameControl();

                customRoutes.navigator(context, customRoutes.home);
              },
              child: Text(
                " Home ",
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
    return (!gameControl.completed)
        ? const SizedBox()
        : Column(
            children: [
              Text(
                "Congratulations! You solved the puzzle!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  color: customColors.primary,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const HomeButton(),
            ],
          );
  }
}
