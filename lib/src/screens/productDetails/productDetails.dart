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
  Animation<double> _width;
  Animation<double> _borderRadius;
  Animation<double> _right;
  Animation<double> _bottom;

  double screenX = appSizes.sizes.width / 2;
  double screenH = appSizes.sizes.height;

  @override
  void initState() {
    super.initState();

    // init anim ctlr
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
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
        curve: Interval(0.1, 0.5, curve: Curves.elasticOut),
      ),
    );

    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller.view,
        curve: Interval(0.1, 0.5, curve: Curves.ease),
      ),
    );

    _width = Tween(
      begin: appSizes.sizes.width - 64,
      end: 64.0,
    ).animate(
      CurvedAnimation(
        parent: _controller.view,
        curve: Interval(0.5, 0.65, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _borderRadius = Tween(
      begin: 8.0,
      end: 27.0,
    ).animate(
      CurvedAnimation(
        parent: _controller.view,
        curve: Interval(0.5, 0.51, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _right = Tween(
      begin: 32.0,
      end: screenX - 32.0,
    ).animate(
      CurvedAnimation(
        parent: _controller.view,
        curve: Interval(0.5, 0.65, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    _bottom = Tween(
      begin: 10.0,
      end: (screenH - appSizes.safePadding.top) - 54,
    ).animate(
      CurvedAnimation(
        parent: _controller.view,
        curve: Interval(0.65, 0.85, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    // start this animation and stop @ half
    _controller.animateTo(0.5).orCancel;
    _controller.addListener((){
      setState(() {
        
      });
    });

    /*=========================================*/
    /*========= add to cart animation =========*/
    /*=========================================*/
  }

  @override
  Widget build(BuildContext context) {
    // screenSize = MediaQuery.of(context).size;
    bottomSafePadding = appSizes.safePadding.bottom;
    // cartBloc = BlocProvider.of<CartBloc>(context);

    timeDilation = 1.0; // 1.0 is normal animation speed.

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
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
                        Text("Options",
                            style: TextStyles.productDetailsSection),
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
                        SizedBox(height: 94 + bottomSafePadding),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 70 + bottomSafePadding,
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 32,
                    right: 32,
                    bottom: bottomSafePadding + 10,
                  ),
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
                ),
              ),
              Positioned(
                bottom: _bottom != null ? _bottom.value : 10.0,
                right: _right != null ? _right.value : 32.0,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final width =
                        _width != null ? _width.value : appSizes.sizes.width - 64.0;
                    final radius = _borderRadius != null ? _borderRadius.value : 8.0;
                    return SizedBox(
                      height: 54,
                      width: width,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..scale(_scale.value, _scale.value, 1.0),
                        alignment: FractionalOffset.center,
                        child: Opacity(
                          opacity: _opacity.value,
                          child: RoundedButton(
                            borderRadius: radius,
                            title: "Ajouter au panier",
                            icon: Icons.add_shopping_cart,
                            onTap: () async {
                              // widget.cartBloc.add(widget.product);
                              try {
                                _right = Tween(
                                  begin: (appSizes.sizes.width / 2 - 32).toDouble(),
                                  end: 5.0,
                                ).animate(
                                  CurvedAnimation(
                                    parent: _controller.view,
                                    curve: Interval(0.65, 0.85, curve: Curves.fastOutSlowIn),
                                  ),
                                );

                                _scale = Tween(
                                  begin: 1.0,
                                  end: 0.35,
                                ).animate(
                                  CurvedAnimation(
                                    parent: _controller.view,
                                    curve: Interval(0.75, 0.85, curve: Curves.fastLinearToSlowEaseIn),
                                  ),
                                );

                                _opacity = Tween(
                                  begin: 1.0,
                                  end: 0.0,
                                ).animate(
                                  CurvedAnimation(
                                    parent: _controller.view,
                                    curve: Interval(0.85, 0.87, curve: Curves.fastLinearToSlowEaseIn),
                                  ),
                                );
                                await _controller.forward(from: 0.25).orCancel;
                                widget.cartBloc.add(widget.product);
                                // await Future.delayed(Duration(milliseconds: 1000));
                                _controller.reset();
                                _right = Tween(
                                  begin: 32.0,
                                  end: (appSizes.sizes.width / 2 - 32).toDouble(),
                                ).animate(
                                  CurvedAnimation(
                                    parent: _controller.view,
                                    curve: Interval(0.5, 0.65, curve: Curves.fastLinearToSlowEaseIn),
                                  ),
                                );
                                _controller.animateTo(0.5).orCancel;
                              } on Error {
                                print(
                                    "Error when forwarding animation $Error");
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: bottomBar(),
    );
  }

  @override
  dispose() {
    _controller.dispose();
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
    return SizedBox(
      height: appSizes.sizes.height,
      // color: Colors.red,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: 70 + bottomSafePadding,
            padding: EdgeInsets.only(
                top: 10, left: 32, right: 32, bottom: bottomSafePadding + 10),
            decoration: BoxDecoration(
              color: AppColors.redAccent,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -1),
                  color: Colors.black.withAlpha(32),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
