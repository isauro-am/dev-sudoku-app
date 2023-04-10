import 'package:flutter/material.dart';

AppBar customAppBar(bool displayMenu, title) {
  return AppBar(
    title: Row(
      children: [
        // (displayMenu) ? customImages.microbit(35, 35) : const SizedBox(),
        Text(title),
      ],
    ),
  );
}
