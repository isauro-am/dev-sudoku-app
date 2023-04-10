

import 'package:flutter/material.dart';

class CustomColors {

  Color black = const Color(0xFF1F262D);
  Color white = const Color(0xFFF1F1F1);
  Color background = const Color(0xFFBCB6B6);
  Color background2 = const Color(0xFFdddddd);


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


  Color blueLightTransparent = const Color(0x6B65816A);
  Color blueTransparent = const Color(0xC0077072);

  Color selectionAlfa = const Color(0xF0074572);
  Color selectionTransparent = const Color(0x94077072);


  textStyle( color ){
    return TextStyle(
        color: color,
        fontSize: 16,
        fontFamily: "verdana_regular",
        fontWeight: FontWeight.w400,
      );

  }

}