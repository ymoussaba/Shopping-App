import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/mainNavigationBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/appTheme.dart';
import 'package:shopping_app/src/screens/mainNavigationScreen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme,
      home: BlocProvider<MainNavigationBloc>(
        bloc: MainNavigationBloc(),
        child: MainNavigationScreen(),
      ),
    );
  }
}