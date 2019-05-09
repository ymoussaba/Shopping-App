import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_app/src/api/productRepository.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/models/product.dart';

class ProductBloc extends BlocBase {
  int _page = 1;
  int _limit = 10;
  bool _reachedEnd = false;
  bool _isLoading = false;
  String _filters = "";
  List<Product> _products = [];

  final _repository = ProductRepository();
  final _subject = PublishSubject<List<Product>>();

  // the stream getter
  Observable<List<Product>> get productsStream => _subject.stream;

  getProducts({bool reload = false}) async {
    // reload if necessary
    if (reload) {
      _page = 1;
      _reachedEnd = false;
    }

    // fetch data only if there are more products
    if (!_reachedEnd && !_isLoading) {
      _isLoading = true;
      ProductsResponse response = await _repository.getProducts(_page, _limit, _filters);
      if (response.error != "" && response.products.isEmpty) {
        _isLoading = false;
        _subject.sink.addError(Error());
      } else {
        if (response.products.length < _limit) {
          _reachedEnd = true;
          print("ProductsResponse _reachedEnd");
        }
        _page++;
        // empty list on reload
        if (reload) _products = [];
        _products.addAll(response.products);
        _isLoading = false;
        _subject.sink.add(_products);
      }
    }
  }

  applyFilter(List<String> filters) {
    //send an null event to trigger loading state
    _subject.sink.add(null);

    _filters = filters.join("|");
    getProducts(reload: true);
  }

  dispose() {
    print("ProductBloc Will dispose");
    _subject.close();
  }

  // PublishSubject<List<Product>> get subject => _subject;
}
