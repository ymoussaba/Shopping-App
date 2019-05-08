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
  static const TextStyle slideTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: AppColors.primary,
  );
  static const TextStyle slideSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}
