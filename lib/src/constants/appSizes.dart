import 'package:flutter/material.dart';

class AppSizes {
  final Size sizes;
  final EdgeInsets safePadding;

  AppSizes(this.sizes, this.safePadding);

  factory AppSizes.fromMediaQuery(MediaQueryData mQData) {
    final apps = AppSizes(
      mQData.size,
      mQData.padding,
    );
    print("AppSizes initialized ${apps.toString()}");
    return apps;
  }
}

AppSizes appSizes;
