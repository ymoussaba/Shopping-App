import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/producBloc.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/models/product.dart';

class ProductsList extends StatefulWidget {
  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("building _ProductsListState");
    // FutureBuilder(
    // );

    var productBloc = BlocProvider.of<ProductBloc>(context);
    // productBloc.getProducts();
    var builder = StreamBuilder(
      stream: productBloc.productsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Product> products = snapshot.data;
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 4,
              childAspectRatio: 0.80,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final product = products[index];
                return _productCard(product);
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

    return builder;
  }

  @override
  void dispose() {
    print("_ProductsListState will dispose");
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

Widget _productCard(Product product) {
  return Card(
    elevation: 4,
    clipBehavior: Clip.hardEdge,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Container(
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
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
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Loading data from API..."),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    ],
  );
}
