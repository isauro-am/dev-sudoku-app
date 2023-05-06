import 'dart:math';

import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/constants/colors.dart';
import 'package:sudoku/ui/settings/widgets/limit_pad.dart';

import '../../constants/game_tags.dart';
import '../../domain/routes.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: customColors.bgBySystem,
        onPressed: () {
          customRoutes.navigator(context, customRoutes.home);
        },
        child: Icon(
          Icons.home,
          color: customColors.white,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tiles_wallpaper/user.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Text(
                  gameTags.settings,
                  style: TextStyle(
                    fontSize: 2.5.rem,
                    color: customColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LimitPad(
                    key: Key(
                      Random().nextInt(100).toString(),
                    ),
                    isError: true,
                    limits: const [
                      ["", 5],
                      ["", 10],
                      ["", 20],
                      ["Unlimited", -1]
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  LimitPad(
                    key: Key(
                      Random().nextInt(100).toString(),
                    ),
                    isError: false,
                    limits: const [
                      ["", 5],
                      ["", 10],
                      ["Disabled", 0]
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
