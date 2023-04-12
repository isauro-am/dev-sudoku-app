import 'package:flutter/material.dart';

import '../ui/home.dart';
import '../ui/sudoku_board/sudoku_board.dart';

CustomRoutes customRoutes = CustomRoutes();

class CustomRoutes {
  // Dashboard
  String get home => "/";
  String get game => "game";

  classRoutes(String route) {
    if (route == home) {
      return const Home();
    }
    if (route == game) {
      return const SudokuBoard();
    }
    return const Home();
  }

  navigator(BuildContext context, String route) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => classRoutes(route),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
