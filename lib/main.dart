import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/cartBloc.dart';
import 'package:shopping_app/src/blocs/mainNavigationBloc.dart';
import 'package:shopping_app/src/constants/appTheme.dart';
import 'package:shopping_app/src/screens/mainNavigationScreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
    // provide cart bloc
    final cartProvider = BlocProvider<CartBloc>(
      bloc: CartBloc(),
      child: MainNavigationScreen(),
    );

    // provide main nav bloc
    final mainNavProvider = BlocProvider<MainNavigationBloc>(
      bloc: MainNavigationBloc(),
      child: cartProvider,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme,
      home: mainNavProvider,
    );
  }
}
