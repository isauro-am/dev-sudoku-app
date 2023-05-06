import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../domain/game_control.dart';

class LimitPadButton extends StatefulWidget {
  final bool isError;
  final String text;
  final int value;
  final Function update;
  const LimitPadButton({
    Key? key,
    required this.text,
    required this.value,
    required this.isError,
    required this.update,
  }) : super(key: key);

  @override
  State<LimitPadButton> createState() => _LimitPadButtonState();
}

class _LimitPadButtonState extends State<LimitPadButton> {
  @override
  Widget build(BuildContext context) {
    int currentLimit =
        (widget.isError) ? gameSettings.errorLimit : gameSettings.cluesLimits;

    return Container(
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: customColors.bgByUser,
        shadowColor: customColors.shadowColor,
        elevation: (currentLimit == widget.value) ? 20 : 0,
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
            if (widget.isError) {
              gameSettings.errorLimit = widget.value;
            } else {
              gameSettings.cluesLimits = widget.value;
            }
            widget.update();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (widget.text != "") ? widget.text : widget.value.toString(),
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
