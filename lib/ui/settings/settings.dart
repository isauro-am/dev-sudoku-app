import 'dart:math';

import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:sudoku/constants/colors.dart';
import 'package:sudoku/domain/game_control.dart';
import 'package:sudoku/ui/settings/widgets/clues_limit.dart';
import 'package:sudoku/ui/settings/widgets/error_limit.dart';

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
    update() {
      setState(() {});
    }

    gameControl.gcUpdate = update;

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
                  ErrorLimit(key: Key(Random().nextInt(1000).toString())),
                  SizedBox(
                    height: 30.h,
                  ),
                  CluesLimit(key: Key(Random().nextInt(1000).toString()))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
