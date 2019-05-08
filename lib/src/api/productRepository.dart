import 'package:shopping_app/src/api/productApiProvider.dart';
import 'package:shopping_app/src/models/product.dart';

class ProductRepository {
  ProductApiProvider _apiProvider = ProductApiProvider();

  Future<ProductsResponse> getProducts(int page, int limit) {
    return _apiProvider.getProducts(page, limit);
  }
}
