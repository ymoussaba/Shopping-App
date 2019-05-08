import 'package:rxdart/rxdart.dart';
import 'package:shopping_app/src/api/productRepository.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/models/product.dart';

class ProductBloc extends BlocBase {
  int _page = 1;
  int _limit = 10;
  bool _reachedEnd = false;
  bool _isLoading = false;
  List<Product> _products = [];

  final _repository = ProductRepository();
  final _subject = BehaviorSubject<List<Product>>();

  // the stream getter
  Observable<List<Product>> get productsStream => _subject.stream;

  getProducts() async {
    // fetch data only if there are more products
    if (!_reachedEnd && !_isLoading) {
      _isLoading = true;
      ProductsResponse response = await _repository.getProducts(_page, _limit);
      if (response.error != "" && response.products.isEmpty) {
        _isLoading = false;
        _subject.sink.addError(Error());
      } else {
        if (response.products.length < _limit) {
          _reachedEnd = true;
        }
        _page++;
        _products.addAll(response.products);
        _isLoading = false;
        _subject.sink.add(_products);
      }
    }
  }

  dispose() {
    print("ProductBloc Will dispose");
    // _subject.close();
  }

  BehaviorSubject<List<Product>> get subject => _subject;
}
