import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/cartBloc.dart';
import 'package:shopping_app/src/blocs/productDetailsBloc.dart';
import 'package:shopping_app/src/commons/roundedButton.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/models/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  CartBloc cartBloc;
  ProductDetailsScreen({@required this.product, @required this.cartBloc});

  var screenSize;
  ProductDetailsBloc detailsBloc = ProductDetailsBloc();
  double bottomSafePadding;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    bottomSafePadding = MediaQuery.of(context).padding.bottom;
    // cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      body: CustomScrollView(
        controller: ScrollController(),
        key: PageStorageKey("detailCustomScroll"),
        slivers: [
          appBar(),
          SliverList(
            key: PageStorageKey("detailSliverList"),
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.all(20),
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20),
                    productTitle(),
                    SizedBox(height: 20),
                    Text("Options", style: TextStyles.productDetailsSection),
                    SizedBox(height: 10),
                    productOptions(),
                    SizedBox(height: 20),
                    Text("Description",
                        style: TextStyles.productDetailsSection),
                    SizedBox(height: 10),
                    Text(
                      "Maecenas faucibus mollis interdum. Nulla vitae elit libero, a pharetra augue. "
                          "Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. "
                          "Cras mattis consectetur purus sit amet fermentum.",
                      style: TextStyles.productDetails,
                    ),
                    SizedBox(height: 40),
                    productInfos(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget appBar() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: screenSize.height * 0.5,
      backgroundColor: AppColors.primary,
      actions: <Widget>[
        StreamBuilder(
          stream: cartBloc.cartStream,
          initialData: List<Product>(),
          builder: (context, snapshot) {
            final List<Product> cart = snapshot.data;
            return Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.shopping_cart),
                  elevation: 0,
                  backgroundColor: AppColors.white,
                  mini: true,
                ),
                cart.length > 0
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 6),
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
                    : Container(width: 0)
              ],
            );
          },
        ),
        SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              child: Hero(
                tag: "heroProduct_${product.id}",
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              width: 120,
              child: Container(
                width: 120,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            product.title,
            style: TextStyles.productDetailsTitle,
          ),
        ),
        SizedBox(width: 40),
        Text(
          "${product.price} €",
          style: TextStyles.productDetailsPrice,
        )
      ],
    );
  }

  Widget productOptions() {
    return StreamBuilder(
      stream: detailsBloc.optionsStream,
      initialData: List<String>(),
      builder: (context, snapshot) {
        return Row(
          children: detailsBloc.options.map(
            (it) {
              final selected = detailsBloc.isSelected(it);
              return Expanded(
                flex: selected ? 65 : 35,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    onPressed: () {
                      detailsBloc.selectOption(it);
                    },
                    child: Text(it),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.grey,
                        width: 1,
                        style: selected ? BorderStyle.none : BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    color:
                        selected ? AppColors.redAccent : AppColors.transparent,
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Widget productInfos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Informations", style: TextStyles.productDetailsSection),
        SizedBox(height: 10),
        Text(
          "Etiam porta sem malesuada magna mollis euismod. Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Vestibulum id ligula porta felis euismod semper. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Cras mattis consectetur purus sit amet fermentum.",
          style: TextStyles.productDetails,
        ),
        SizedBox(height: 40),
        Text("Delivery & Returns", style: TextStyles.productDetailsSection),
        SizedBox(height: 10),
        Text(
          "Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Sed posuere consectetur est at lobortis. Maecenas faucibus mollis interdum. Donec ullamcorper nulla non metus auctor fringilla.",
          style: TextStyles.productDetails,
        ),
      ],
    );
  }

  Widget bottomBar() {
    return Container(
      height: 70 + bottomSafePadding,
      padding: EdgeInsets.only(top: 10, left: 32, right: 32, bottom: bottomSafePadding + 10),
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, -1),
          color: Colors.black.withAlpha(32),
          blurRadius: 5,
        ),
      ]),
      child: SizedBox(
        width: 120,
        child: RoundedButton(
          title: "Ajouter au panier",
          icon: Icons.add_shopping_cart,
          onTap: (){
            cartBloc.add(product);
          },
        ),
      ),
    );
  }
}
