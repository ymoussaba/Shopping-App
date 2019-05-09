import 'package:dio/dio.dart';
import 'package:shopping_app/src/models/product.dart';

class ProductApiProvider {
  final String _endpoint = "http://5cd1779fd4a78300147beb2c.mockapi.io/product";
  final Dio _dio = Dio();

  ProductApiProvider(){
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  Future<ProductsResponse> getProducts(int page, int limit, String filter) async {
    try {
      Response response = await _dio.get("$_endpoint?page=$page&limit=$limit&filter=$filter");
      return ProductsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("ProductApiProvider Exception occured: $error stackTrace: $stacktrace");
      return ProductsResponse.withError("$error");
    }
  }
}
