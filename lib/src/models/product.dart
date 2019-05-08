import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String price;
  final String product;
  final String category;
  final String description;
  final String imageUrl;

  Product({
    this.id,
    this.title,
    this.price,
    this.product,
    this.category,
    this.description,
    this.imageUrl
  }) : super([id, title, price, product, category, description, imageUrl]);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      product: json['product'],
      category: json['category'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
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
