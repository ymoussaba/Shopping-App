import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/mainNavigationBloc.dart';
import 'package:shopping_app/src/blocs/producBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/screens/home/home.dart';

class MainNavigationScreen extends StatelessWidget {
  final homeScreen = BlocProvider<ProductBloc>(
    bloc: ProductBloc(),
    child: HomeScreen(),
  );
  final cartScreen = Center(
    child: Text("CART"),
  );
  final profileScreen = Center(
    child: Text("PROFILE"),
  );
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      homeScreen,
      cartScreen,
      profileScreen,
    ];

    final navigationBloc = BlocProvider.of<MainNavigationBloc>(context);
    final _tabController = TabController(
      length: 3,
      initialIndex: 1,
      vsync: AnimatedListState(),
    );
    _tabController.addListener(() {
      navigationBloc.navigateTo(_tabController.index);
    });

    return Scaffold(
      body: StreamBuilder(
        stream: navigationBloc.navStream,
        initialData: navigationBloc.defaultIndex,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          final index = snapshot.data;
          return IndexedStack(
            index: index,
            children: screens,
          );
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
                title: Text('Home', style: TextStyles.barItemTitle),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: BarItemIcon(ImagesResources.cartIcon),
                title: Text('Cart', style: TextStyles.barItemTitle),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: BarItemIcon(ImagesResources.profileIcon),
                title: Text('Profile', style: TextStyles.barItemTitle),
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

  Widget BarItemIcon(String icon) {
    return Image.asset(
      icon,
      color: AppColors.white,
      width: 24,
    );
  }
}
