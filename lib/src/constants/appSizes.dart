import 'package:flutter/material.dart';

class AppSizes {
  final Size sizes;
  final EdgeInsets safePadding;

  AppSizes(this.sizes, this.safePadding);

  factory AppSizes.fromMediaQuery(MediaQueryData mQData) {
    print("AppSizes initialized");
    return AppSizes(
      mQData.size,
      mQData.padding,
    );
  }
}

AppSizes appSizes;
