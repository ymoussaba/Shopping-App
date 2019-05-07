import 'package:flutter/material.dart';
import 'package:shopping_app/src/constants/appColors.dart';

var AppTheme = ThemeData(
  primarySwatch: AppColors.primary,
  fontFamily: "Montserrat",
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.black, size: 24),
    brightness: Brightness.light,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: AppColors.white,
    elevation: 1,
    shape: CircularNotchedRectangle(),
  ),
  bottomAppBarColor: AppColors.primary,
  iconTheme: IconThemeData(
    color: AppColors.black,
    size: 24,
  ),
  scaffoldBackgroundColor: AppColors.white,
);
