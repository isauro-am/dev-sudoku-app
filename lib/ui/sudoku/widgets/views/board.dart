import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../draw_board/draw_board.dart';
import '../home_button.dart';
import '../number_pad/number_pad.dart';
import '../pad_menu/pad_menu.dart';

class BoardGame extends StatelessWidget {
  const BoardGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const HomeButton(),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/tiles_wallpaper/system.jpg'),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: customColors.primary,
              width: 3.0,
            ),
          ),
          child: const DrawPanel(),
        ),
        // Draw the pad menu
        const PadMenu(),

        const SizedBox(
          height: 10,
        ),
        const NumberPad(init: 1, end: 10),
      ],
    );
  }
}
