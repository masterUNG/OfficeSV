import 'package:flutter/material.dart';

class MyConstant {
  // field
  static String appName = 'Officer Sv';

  static Color primary = const Color(0xffc257b7);
  static Color dark = const Color(0xff8f2487);
  static Color light = const Color(0xfff788ea);

  // method

  TextStyle h1Style() => TextStyle(
        fontSize: 30,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
}
