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
      body: Container(
        alignment: Alignment.center,
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
                  return Row(
                    children: <Widget>[
                      Container(
                        width: screenSize.width * 0.33,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Card(
                            elevation: 0,
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
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
