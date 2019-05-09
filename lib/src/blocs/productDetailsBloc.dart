import 'package:rxdart/rxdart.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';

class ProductDetailsBloc extends BlocBase {
  final _options = ["Small", "Medium", "Large"];
  var _selectedOptions = Set<String>();

  final _subject = BehaviorSubject<List<String>>();

  List<String> get options => _options;
  Observable<List<String>> get optionsStream => _subject.stream;

  void selectOption(String option) {
    _selectedOptions = Set();
    _selectedOptions.add(option);
    _subject.sink.add(_selectedOptions.toList());
  }

  bool isSelected(String option) {
    return _selectedOptions.contains(option);
  }

  @override
  void dispose() {
    _subject.drain().then((_){
      _subject.close();
    });
  }
}
