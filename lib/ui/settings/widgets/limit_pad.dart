import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../../../constants/colors.dart';
import '../../../constants/game_tags.dart';
import 'limit_pad_button.dart';

class LimitPad extends StatefulWidget {
  final bool isError;
  final List limits;

  const LimitPad({
    Key? key,
    required this.isError,
    required this.limits,
  }) : super(key: key);

  @override
  State<LimitPad> createState() => _LimitPadState();
}

class _LimitPadState extends State<LimitPad> {
  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];

    update() {
      setState(() {});
    }

    for (var element in widget.limits) {
      buttons.add(LimitPadButton(
        text: element[0],
        value: element[1],
        isError: widget.isError,
        update: update,
      ));
    }

    return Container(
      margin: EdgeInsets.all(10.h).copyWith(top: 20.h),
      child: Column(
        children: [
          Text(
            (widget.isError) ? gameTags.settingsError : gameTags.settingsClues,
            style: TextStyle(
              fontSize: 1.2.rem,
              color: customColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buttons,
          ),
          SizedBox(height: 15.h),
          Text(
            textAlign: TextAlign.center,
            (widget.isError) ? gameTags.errorInfo : gameTags.cluesInfo,
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
