import 'dart:math';

import 'package:equatable/equatable.dart';

final _productImages = [
  "https://source.unsplash.com/BbypBSBbOGU/620x720/",
  "https://source.unsplash.com/EF7BVa9BB2M/620x720/",
  "https://source.unsplash.com/sRyvf4szfMc/620x720/",
  "https://source.unsplash.com/nMffL1zjbw4/620x720/",
  "https://source.unsplash.com/VSYq9nS-fY0/620x720/",
  "https://source.unsplash.com/4kTbAMRAHtQ/620x720/",
  "https://source.unsplash.com/2cFZ_FB08UM/620x720/",
  "https://source.unsplash.com/P44RIGl9V54/620x720/",
  "https://source.unsplash.com/6LBBOwkPzyQ/620x720/",
  "https://source.unsplash.com/a-QH9MAAVNI/620x720/",
  "https://source.unsplash.com/E-0ON3VGrBc/620x720/",
  "https://source.unsplash.com/PDX_a_82obo/620x720/",
  "https://source.unsplash.com/dBwadhWa-lI/620x720/",
  "https://source.unsplash.com/NuOGFo4PudE/620x720/",
  "https://source.unsplash.com/nGzvZe1iWOY/620x720/",
  "https://source.unsplash.com/n_wXNttWVGs/620x720/",
  "https://source.unsplash.com/gByOS-Vss2E/620x720/",
  "https://source.unsplash.com/TLifm8L8eM8/620x720/",
  "https://source.unsplash.com/bz-p9ZHtvUQ/620x720/",
  "https://source.unsplash.com/KCvIMGo-1nc/620x720/",
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
