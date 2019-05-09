import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/cartBloc.dart';
import 'package:shopping_app/src/blocs/filterBloc.dart';
import 'package:shopping_app/src/blocs/mainNavigationBloc.dart';
import 'package:shopping_app/src/blocs/producBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/models/product.dart';
import 'package:shopping_app/src/screens/cart/cart.dart';
import 'package:shopping_app/src/screens/home/home.dart';

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  BlocProvider<ProductBloc> productProvider;
  BlocProvider<FilterBloc> filterProvider;
  CartBloc cartBloc;
  FilterBloc _filterBloc;
  MainNavigationBloc navigationBloc;
  List<Widget> screens;

  TabController _tabController;

  final cartScreen = CartScreen();
  final profileScreen = Center(
    child: Text("PROFILE"),
  );

  @override
  void initState() {
    super.initState();
    // Get the cart bloc for cart Bar item notification badge
    cartBloc = BlocProvider.of<CartBloc>(context);

    productProvider = BlocProvider<ProductBloc>(
      bloc: ProductBloc(),
      child: HomeScreen(),
    );

    _filterBloc = FilterBloc();
    _filterBloc.filterStream.listen(productProvider.bloc.applyFilter);

    filterProvider = BlocProvider<FilterBloc>(
      bloc: _filterBloc,
      child: productProvider,
    );

    screens = [
      filterProvider,
      cartScreen,
      profileScreen,
    ];
    navigationBloc = BlocProvider.of<MainNavigationBloc>(context);
    _tabController = TabController(
      length: 3,
      vsync: AnimatedListState(),
    );
    _tabController.addListener(() {
      navigationBloc.navigateTo(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {

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
                // icon: BarItemIcon(ImagesResources.cartIcon),
                icon: StreamBuilder(
                  stream: cartBloc.cartStream,
                  initialData: List<Product>(),
                  builder: (context, snapshot) {
                    final List<Product> cart = snapshot.data;
                    return Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        BarItemIcon(ImagesResources.cartIcon),
                        cart.length > 0
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 6),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: new Text(
                                  '${cart.length}',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(width: 0),
                      ],
                    );
                  },
                ),
                title: Text('Cart', style: TextStyles.barItemTitle),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.orange,
                icon: BarItemIcon(ImagesResources.profileIcon),
                title: Text('Profile', style: TextStyles.barItemTitle),
              ),
            ],
            currentIndex: index,
            // iconSize: 12,
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
