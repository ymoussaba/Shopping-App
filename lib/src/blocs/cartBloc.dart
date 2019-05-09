import 'package:rxdart/rxdart.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';
import 'package:shopping_app/src/models/product.dart';

class CartBloc extends BlocBase {
  var _cart = List<Product>();
  BehaviorSubject<List<Product>> _subject;

  CartBloc(){
    _subject = BehaviorSubject<List<Product>>.seeded(_cart);
  }

  Observable<List<Product>> get cartStream => _subject.stream;

  void add(Product product) {
    _cart.add(product);
    _subject.sink.add(_cart);
  }

  void remove(Product product){
    _cart.remove(product);
    _subject.sink.add(_cart);
  }

  @override
  void dispose() {
    _subject.close();
  }
}
