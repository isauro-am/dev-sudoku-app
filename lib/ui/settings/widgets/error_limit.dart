import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../constants/game_tags.dart';
import 'error_button.dart';

class ErrorLimit extends StatelessWidget {
  const ErrorLimit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.h).copyWith(top: 20.h),
      child: Column(
        children: [
          Text(
            gameTags.settingsError,
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
              ErrorButton(text: "", value: 5),
              ErrorButton(text: "", value: 10),
              ErrorButton(text: "", value: 20),
              ErrorButton(text: "Unlimited", value: -1),
            ],
          ),
          SizedBox(height: 15.h),
          Text(
            textAlign: TextAlign.center,
            gameTags.errorInfo,
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
