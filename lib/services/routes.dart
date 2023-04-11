import 'package:flutter/material.dart';

import '../ui/home.dart';

class CustomRoutes {
  // Dashboard
  String get home => "/";
  String get game => "game";

  classRoutes(String route) {
    if (route == home) {
      return const Home();
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
