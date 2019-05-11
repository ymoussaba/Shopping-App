import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/cartBloc.dart';
import 'package:shopping_app/src/blocs/mainNavigationBloc.dart';
import 'package:shopping_app/src/commons/roundedButton.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/images.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/models/product.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  MainNavigationBloc navigationBloc;
  CartBloc cartBloc;
  Size screenSize;

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    navigationBloc = BlocProvider.of<MainNavigationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("YOUR CART", style: TextStyles.title),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 120),
            child: StreamBuilder(
              stream: cartBloc.cartStream,
              initialData: List<Product>(),
              builder: (context, snapshot) {
                List<Product> products = snapshot.data;
                if (products == null || products.length == 0) {
                  return emptyCart();
                }
                return Container(
                  padding: EdgeInsets.all(20),
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Product product = products[index];
                      return productItem(product, index);
                    },
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: StreamBuilder<Object>(
                stream: cartBloc.cartStream,
                builder: (context, snapshot) {
                  List<Product> products = snapshot.data;
                  if (products == null || products.length == 0) {
                    return Container(width: 0);
                  }
                  final totalAmount = products
                      .map((it) => double.parse(it.price))
                      .reduce((x, y) => x + y);
                  return Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, -1),
                          color: Colors.black.withAlpha(32),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Total Price (${products.length} items) : ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${totalAmount.toStringAsFixed(2)} €",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Text(
                              "Delivery :",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Free",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.redAccent),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        RoundedButton(
                          title: "Continue",
                          onTap: () {},
                          color: Colors.green,
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget productItem(Product product, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColors.lightGrey,
            ),
          ),
        ),
        padding: EdgeInsets.only(bottom: 10),
        height: 124,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Card(
                margin: EdgeInsets.all(0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product.title,
                        style: TextStyles.productCartTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // SizedBox(height: 5),
                      // Text("${product.product}, ${product.category}"),
                      SizedBox(height: 5),
                      Text("Quantity: 1"),
                      SizedBox(height: 5),
                      Text("${product.price} €", style: TextStyles.productPrice),
                    ],
                  ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          //append index to avoid duplicate id for same product
                          heroTag: "delete_${product.id}_$index",
                          backgroundColor: AppColors.redAccent,
                          foregroundColor: AppColors.white,
                          onPressed: () {
                            cartBloc.remove(product);
                          },
                          child: Icon(Icons.delete),
                          mini: true,
                          elevation: 0,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emptyCart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          ImagesResources.cartIcon,
          height: 92,
        ),
        SizedBox(height: 20),
        Text(
          "Your cart is empty",
          style: TextStyles.text,
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 280,
          child: RoundedButton(
            title: "Go add some cool stuff to buy",
            onTap: () {
              navigationBloc.navigateTo(0);
            },
          ),
        )
      ],
    );
  }
}
