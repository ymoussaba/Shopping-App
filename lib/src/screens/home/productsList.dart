import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/cartBloc.dart';
import 'package:shopping_app/src/blocs/producBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/models/product.dart';
import 'package:shopping_app/src/screens/productDetails/productDetails.dart';

class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  CartBloc cartBloc;
  ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // cartProvider =
    return StreamBuilder(
      stream: productBloc.productsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Product> products = snapshot.data;
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 4,
              childAspectRatio: 0.70,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final product = products[index];
                return _productCard(context, product);
              },
              childCount: products.length,
            ),
          );
        } else if (snapshot.hasError) {
          return _errorWidget("${snapshot.error}");
        } else {
          return _loadingWidget();
        }
      },
    );
  }

  Widget _productCard(BuildContext context, Product product) {
    return Card(
      color: AppColors.white,
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  ProductDetailsScreen(product: product, cartBloc: cartBloc),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.lightGrey,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                  Hero(
                    tag: "heroProduct_${product.id}",
                    child: Container(
                      width: double.infinity,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: "fav_${product.id}",
                    key: Key("fav_${product.id}"),
                    backgroundColor: AppColors.transparent,
                    elevation: 0,
                    child: Icon(
                      Icons.favorite_border,
                      color: AppColors.redAccent,
                    ),
                    onPressed: () => {},
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${product.title}",
                    style: TextStyles.productTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  // Text("TELLUS, ELIT", style: TextStyles.productTag),
                  // SizedBox(height: 4),
                  Container(
                    height: 2,
                    width: 20,
                    color: AppColors.lightGrey,
                  ),
                  SizedBox(height: 4),
                  Text("${product.price} €", style: TextStyles.productPrice),
                ],
              ),
            ),
          ],
        ),
      ),
      // margin: EdgeInsets.only(bottom: 20, top: 5, left: 4, right: 4),
    );
  }

  Widget _errorWidget(String error) {
    return SliverGrid.count(
      crossAxisCount: 1,
      childAspectRatio: 16 / 9,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error occured: $error"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _loadingWidget() {
    return SliverGrid.count(
      crossAxisCount: 1,
      childAspectRatio: 16 / 9,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Center(
            child: Image.asset(ImagesResources.searchAnim),
          ),
        ),
      ],
    );
  }
}
