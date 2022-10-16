

import 'package:flutter/material.dart';

class CustomColors {

  Color black = const Color.fromRGBO(31, 38, 45, 1);
  Color white = const Color.fromARGB(255, 241, 241, 241);
  Color background = const Color(0xFFdddddd);


  Color blueLight = const Color(0xFF31aae1);
  Color menu = const Color(0xFF1f262d);
  

  Color inputBorder = const Color(0xFF1f262d);

  Color yellowLight = const Color(0xFF383A0E);
  Color yellow = const Color(0xFFD6DF1C);


  // Default
  Color grey = const Color(0xFF9E9E9E);
  Color error = const Color(0xFF94140B);

  Color green = const Color(0xFF077219);
  Color greenLight = const Color(0xFF65816A);


  Color blueLightTransparent = const Color.fromARGB(107, 101, 129, 106);
  Color blueTransparent = Color.fromARGB(192, 7, 112, 114);


  textStyle( color ){
    return TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: "verdana_regular",
        fontWeight: FontWeight.w400,
      );

  }

}