import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';

class LimitPadButton extends StatelessWidget {
  final bool isError;
  final String text;
  final int value;
  const LimitPadButton({
    Key? key,
    required this.text,
    required this.value,
    required this.isError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentLimit =
        (isError) ? gameControl.errorLimit : gameControl.cluesLimit;

    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: customColors.bgByUser,
        shadowColor: customColors.shadowColor,
        elevation: (currentLimit == value) ? 20 : 0,
        child: TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: customColors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            iconColor: MaterialStateProperty.all(customColors.primary),
          ),
          onPressed: () {
            if (isError) {
              gameControl.errorLimit = value;
            } else{
              gameControl.cluesLimit = value;
            }
            gameControl.gcUpdate();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (text != "") ? text : value.toString(),
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: customColors.primary,
                  fontSize: 0.8.rem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
