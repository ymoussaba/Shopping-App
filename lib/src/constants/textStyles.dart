import 'package:flutter/material.dart';
import 'package:shopping_app/src/constants/appColors.dart';

class TextStyles {
  static TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle subTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const _titleShadowColor = Color(0x99000000);
  static const _subTitleShadowColor = Color(0x99FFFFFF);
  static const TextStyle slideTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.primary,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0, 2),
        blurRadius: 3,
        color: _titleShadowColor,
      ),
    ]
  );
  static const TextStyle slideSubtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0, 1),
        blurRadius: 10,
        color: _subTitleShadowColor,
      ),
    ]
  );
}
