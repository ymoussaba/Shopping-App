import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.orange;
  static Color primaryDark = Colors.orange[900];
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static Color transparent = Colors.transparent;
  static const Color transparentBlack = Colors.black;
}

class AppDecorations {
  static const BoxDecoration transparentToBlackGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0, 0.45, 1],
      colors: [
        Color(0x00000000),
        Color(0x00000000),
        Color(0xFF000000),
      ],
    ),
  );
}
