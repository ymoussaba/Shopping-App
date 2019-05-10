import 'package:flutter/material.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/blocs/cartBloc.dart';
import 'package:shopping_app/src/blocs/productDetailsBloc.dart';
import 'package:shopping_app/src/commons/roundedButton.dart';
import 'package:shopping_app/src/constants/appColors.dart';
import 'package:shopping_app/src/constants/appSizes.dart';
import 'package:shopping_app/src/constants/textStyles.dart';
import 'package:shopping_app/src/models/product.dart';

import 'package:flutter/scheduler.dart' show timeDilation;

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  CartBloc cartBloc;
  ProductDetailsScreen({@required this.product, @required this.cartBloc});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  double bottomSafePadding;
  ProductDetailsBloc detailsBloc = ProductDetailsBloc();

  AnimationController _controller;
  AnimationController _addToCartController;

  Animation<double> _scale;
  Animation<double> _opacity;

  Animation<double> _toCartWidth;
  Animation<double> _toCartBorderRadius;
  Animation<double> _toCartOpacity;
  Animation<double> _toCartRight;

  // Animation<double> _top;
  // Animation<double> _right;
  double screenX = appSizes.sizes.width / 2;

  @override
  void initState() {
    super.initState();

    // init anim ctlr
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _addToCartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    /*=========================================*/
    /*============ main button anim ===========*/
    /*=========================================*/

    _scale = Tween(
      begin: 0.4,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller.view,
        curve: Interval(0.25, 1.0, curve: Curves.elasticOut),
      ),
    );

    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller.view,
        curve: Interval(0.25, 1.0, curve: Curves.ease),
      ),
    );

    // start this animation
    _controller.forward().orCancel;

    /*=========================================*/
    /*========= add to cart animation =========*/
    /*=========================================*/

    _toCartBorderRadius = Tween(
      begin: 8.0,
      end: 75.0,
    ).animate(
      CurvedAnimation(
        parent: _addToCartController.view,
        curve: Interval(0.0, 0.25, curve: Curves.easeInCirc),
      ),
    );

    _toCartWidth = Tween(
      begin: 200.0,
      end: 54.0,
    ).animate(
      CurvedAnimation(
        parent: _addToCartController.view,
        curve: Interval(0.0, 0.25, curve: Curves.easeInCirc),
      ),
    );

    _toCartOpacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _addToCartController.view,
        curve: Interval(0.0, 0.0, curve: Curves.easeInCirc),
      ),
    );
    // final right = appSizes.sizes.width;
    // _toCartRight = Tween(
    //   begin: 200.0,
    //   end: 12,
    // ).animate(
    //   CurvedAnimation(
    //     parent: _addToCartController.view,
    //     curve: Interval(0.0, 1.0, curve: Curves.ease),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    // screenSize = MediaQuery.of(context).size;
    bottomSafePadding = appSizes.safePadding.bottom;
    // cartBloc = BlocProvider.of<CartBloc>(context);

    timeDilation = 1.0; // 1.0 is normal animation speed.

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

  @override
  dispose() {
    _controller.dispose();
    _addToCartController.dispose();
    detailsBloc.dispose();
    super.dispose();
  }

  Widget appBar() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: appSizes.sizes.height * 0.5,
      backgroundColor: AppColors.primary,
      actions: <Widget>[
        StreamBuilder(
          stream: widget.cartBloc.cartStream,
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
        background: Container(
          child: Hero(
            tag: "heroProduct_${widget.product.id}",
            child: Image.network(
              widget.product.image,
              fit: BoxFit.cover,
            ),
          ),
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
            widget.product.title,
            style: TextStyles.productDetailsTitle,
          ),
        ),
        SizedBox(width: 40),
        Text(
          "${widget.product.price} €",
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
    return Stack(
      children: <Widget>[
        Positioned(
          width: appSizes.sizes.width,
          height: appSizes.sizes.height,
          child: AnimatedBuilder(
            animation: _addToCartController,
            builder: (context, child) {
              final borderRadius =
                  _toCartBorderRadius != null ? _toCartBorderRadius.value : 8;
              // final right = screenX;
              return Container(
                // height: 54 + bottomSafePadding,
                color: Colors.pinkAccent,
                // height: appSizes.sizes.height,
                // width: appSizes.sizes.width,
                // alignment: Alignment.bottomCenter,
                // color: Colors.tealAccent,
                child: Opacity(
                  opacity: _toCartOpacity.value,
                  child: Container(
                    transform: Matrix4.translationValues(10, 0, 0),
                    height: 54,
                    width: _toCartWidth.value,
                    child: RoundedButton(
                      borderRadius: borderRadius,
                      title: "",
                      onTap: () async {},
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
            height: 70 + bottomSafePadding,
            padding: EdgeInsets.only(
                top: 10, left: 32, right: 32, bottom: bottomSafePadding + 10),
            decoration: BoxDecoration(
              color: AppColors.transparent,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -10),
                  color: Colors.black.withAlpha(32),
                  blurRadius: 5,
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..scale(_scale.value, _scale.value, 1.0),
                  alignment: FractionalOffset.center,
                  child: Opacity(
                    opacity: _opacity.value,
                    child: RoundedButton(
                      title: "Ajouter au panier",
                      icon: Icons.add_shopping_cart,
                      onTap: () async {
                        // widget.cartBloc.add(widget.product);
                        try {
                          _controller.reverse().orCancel;
                          await Future.delayed(Duration(milliseconds: 750));
                          _addToCartController.forward().orCancel;
                          // await Future.delayed(Duration(milliseconds: 50000));
                          // await _controller.forward().orCancel;
                        } on Error {
                          print("Error when forwarding animation $Error");
                        }
                      },
                    ),
                  ),
                );
              },
            )),
      ],
    );
  }
}
