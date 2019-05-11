import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/filterBloc.dart';
import 'package:shopping_app/src/blocs/producBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/screens/home/carousel.dart';
import 'package:shopping_app/src/screens/home/filterBar.dart';
import 'package:shopping_app/src/screens/home/productsList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  bool keepAlive = true;
  final _scrollController = ScrollController(keepScrollOffset: true);
  final _scrollThreshold = 800.0;
  ProductBloc productBloc;
  FilterBloc filterBloc;

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    filterBloc = BlocProvider.of<FilterBloc>(context);
    productBloc.getProducts();

    _scrollController.addListener(() {
      bool hasClient = _scrollController.hasClients;
      bool hasCtlr = _scrollController.positions.length > 0;

      if (!hasClient || hasCtlr) {
        // print("hasClient || hasCtlr ");
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (maxScroll - currentScroll <= _scrollThreshold) {
          productBloc.getProducts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "HOME",
          style: TextStyles.title,
        ),
        actions: <Widget>[
          InkWell(
            // splashColor: AppColors.white,
            highlightColor: AppColors.primary.withAlpha(35),
            radius: 16,
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Image.asset(
              ImagesResources.chatIcon,
              height: 32,
              width: 32,
              color: AppColors.black,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        color: AppColors.lightestGrey,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          backgroundColor: AppColors.primary,
          color: AppColors.white,
          child: CustomScrollView(
            key: PageStorageKey("HomeCustomScrollView"),
            controller: _scrollController,
            // cacheExtent: 400,
            slivers: <Widget>[
              FilterBar(),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Carousel(),
                  ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 20),
                sliver: ProductsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    print("Refreshing");
    productBloc.productsStream.listen((products) {
      return null;
    });
    productBloc.getProducts(reload: true);
  }

  @override
  bool get wantKeepAlive => keepAlive;
}
