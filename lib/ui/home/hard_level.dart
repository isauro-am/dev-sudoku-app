import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../domain/game_control.dart';

Container selectHardLevel(int star, String text, Function update) {
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
        opacity: (gameControl.dificult == dificult) ? 1 : 0.4,
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
            (gameControl.dificult == dificult) ? 30 : 1),
      ),
      onPressed: () {
        gameControl.dificult = dificult;
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
