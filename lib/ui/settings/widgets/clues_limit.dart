import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../constants/game_tags.dart';
import 'clues_button.dart';

class CluesLimit extends StatelessWidget {
  const CluesLimit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.h).copyWith(top: 20.h),
      child: Column(
        children: [
          Text(
            gameTags.settingsClues,
            style: TextStyle(
              fontSize: 1.2.rem,
              color: customColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              ClueButton(text: "", value: 5),
              ClueButton(text: "", value: 10),
              ClueButton(text: "Disabled", value: 0),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            textAlign: TextAlign.center,
            gameTags.cluesInfo,
            style: TextStyle(
              color: customColors.primary,
              fontSize: 0.8.rem,
            ),
          ),
        ],
      ),
    );
  }
}
