import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/constants/game_tags.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';
import '../../../domain/routes.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          gameSettings.reset();

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
