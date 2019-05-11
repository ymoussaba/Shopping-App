import 'dart:math';

import 'package:equatable/equatable.dart';

final _productImages = [
  "https://images.unsplash.com/photo-1544578122-5b51d9662d36?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1522273400909-fd1a8f77637e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/flagged/photo-1550713090-5a093719add2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1484981138541-3d074aa97716?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1507878566509-a0dbe19677a5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1503602642458-232111445657?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1518131672697-613becd4fab5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1526947425960-945c6e72858f?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1543163521-1bf539c55dd2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1505740106531-4243f3831c78?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1504274066651-8d31a536b11a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1518444065439-e933c06ce9cd?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1543512214-318c7553f230?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1528310385748-dba09bf1657a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1528384483229-b4a97480dbea?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1556217257-aa1d0c385e62?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1525278083600-68f228a0e0eb?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1511556820780-d912e42b4980?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1491553895911-0055eca6402d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1481016570479-9eab6349fde7?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1539784257995-d70d6089a5c8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1516048015710-7a3b4c86be43?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1516048574519-4ec74b0217be?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1509587584298-0f3b3a3a1797?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1545877968-e8e1404dc066?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1503236823255-94609f598e71?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1474508297924-60ae8de135eb?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1534322334759-a27b0dcc4b34?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1534260164206-2a3a4a72891d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1523426366168-ab13c3cccb03?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1523264067855-7b9941f18ca9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1489269637500-aa0e75768394?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1535486607281-4fc90307a8bb?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
  "https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=620&h=720&fit=crop&ixid=eyJhcHBfaWQiOjF9",
];

final _random = new Random();
String _getRandomImage() {
  final index = _random.nextInt(_productImages.length);
  return _productImages[index];
}

class Product extends Equatable {
  final String id;
  final String title;
  final String price;
  final String product;
  final String category;
  final String description;
  final String imageUrl;
  String image;
  bool bookmarked = false;

  Product({
    this.id,
    this.title,
    this.price,
    this.product,
    this.category,
    this.description,
    this.imageUrl,
  })  : image = _getRandomImage(),
        super([id, title, price, product, category, description, imageUrl]);

  factory Product.fromJson(Map<String, dynamic> json) {
    final prod = Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      product: json['product'],
      category: json['category'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
    prod.image = _getRandomImage();
    return prod;
  }

  @override
  String toString() => 'Product { id: $id }';
}

class ProductsResponse {
  final List<Product> products;
  final String error;

  ProductsResponse(this.products, this.error);

  factory ProductsResponse.fromJson(List<dynamic> jsonList) {
    final results = jsonList.map((it) => Product.fromJson(it)).toList();
    final error = "";
    return ProductsResponse(results, error);
  }

  factory ProductsResponse.withError(String errorValue) {
    final results = List<Product>(), error = errorValue;
    return ProductsResponse(results, error);
  }
}
