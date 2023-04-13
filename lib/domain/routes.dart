import 'package:flutter/material.dart';
import 'package:sudoku/ui/settings/settings.dart';

import '../ui/home/home.dart';
import '../ui/sudoku_board/sudoku_board.dart';

CustomRoutes customRoutes = CustomRoutes();

class CustomRoutes {
  // Dashboard
  String get home => "/";
  String get game => "game";
  String get settings => "settings";

/// The function returns a widget based on the input route string.
/// 
/// Args:
///   route (String): The parameter "route" is a string that represents the route to be taken in a
/// navigation system. It is used in the function to determine which screen to display based on the
/// route provided.
/// 
/// Returns:
///   The function `classRoutes` takes a string parameter `route` and returns a widget based on the
/// value of `route`. The function is used in the `navigator` function to navigate to a specific screen.
  classRoutes(String route) {
    if (route == home) {
      return const Home();
    }
    if (route == game) {
      return const SudokuBoard();
    }
    if (route == settings) {
      return const Settings();
    }
    return const Home();
  }

  /// This function navigates to a new page in a Flutter app using a specified route and replaces the
  /// current page.
  /// 
  /// Args:
  ///   context (BuildContext): The BuildContext is an object that contains information about the
  /// current build context, such as the location of the widget in the widget tree. It is typically used
  /// to access the Theme, MediaQuery, and Navigator objects.
  ///   route (String): The `route` parameter is a string that represents the name of the route to
  /// navigate to. It is used to determine which screen or page to display next.
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
