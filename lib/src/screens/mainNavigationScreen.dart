import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/mainNavigationBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
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
                icon: BarItemIcon(ImagesResources.homeIcon),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: BarItemIcon(ImagesResources.cartIcon),
                title: Text('Cart'),
              ),
              BottomNavigationBarItem(
                icon: BarItemIcon(ImagesResources.profileIcon),
                title: Text('Profile'),
              ),
            ],
            currentIndex: index,
            iconSize: 12,
            onTap: (index) {
              navigationBloc.navigateTo(index);
            },
            type: BottomNavigationBarType.shifting,
          );
        },
      ),
    );
  }

  Widget BarItemIcon(String icon){
    return Image.asset(icon, color: AppColors.white, width: 24,);
  }
}
