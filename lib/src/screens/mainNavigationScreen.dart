import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/mainNavigationBloc.dart';
import 'package:shopping_app/src/screens/home.dart';

class MainNavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      Center(
        child: Text("CART"),
      ),
      Center(
        child: Text("PROFILE"),
      ),
    ];

    final MainNavigationBloc navigationBloc =
        BlocProvider.of<MainNavigationBloc>(context);
    TabController _tabController =
        TabController(length: 3, initialIndex: 1, vsync: AnimatedListState());
    _tabController.addListener(() {
      navigationBloc.navigateTo(_tabController.index);
    });

    return Scaffold(
      body: StreamBuilder(
        stream: navigationBloc.navStream,
        initialData: navigationBloc.defaultIndex,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          final index = snapshot.data;
          return screens[index];
        },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: navigationBloc.navStream,
        initialData: navigationBloc.defaultIndex,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          final index = snapshot.data;
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: Icon(Icons.home),
                title: Text('HOME'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                title: Text('CART'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('PROFILE'),
              ),
            ],
            currentIndex: index,
            fixedColor: Colors.orange,
            onTap: (index) {
              navigationBloc.navigateTo(index);
            },
            type: BottomNavigationBarType.shifting,
          );
        },
      ),
    );
  }
}
