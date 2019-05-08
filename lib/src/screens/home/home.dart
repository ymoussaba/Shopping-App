import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/producBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/screens/home/carousel.dart';
import 'package:shopping_app/src/screens/home/productsList.dart';

class HomeScreen extends StatelessWidget {
  final _scrollController = ScrollController();
  final _scrollThreshold = 500.0;

  @override
  Widget build(BuildContext context) {
    var productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.getProducts();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= _scrollThreshold) {
        productBloc.getProducts();
      }
    });
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
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          cacheExtent: 400,
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Sliver App Bar',
              ),
              floating: true,
              elevation: 4.0,
            ),
            SliverGrid.count(
              crossAxisCount: 1,
              childAspectRatio: 16 / 9,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Carousel(),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 20),
              sliver: ProductsList(),
            ),
          ],
        ),
      ),
    );
  }
}
