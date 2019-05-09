import 'package:rxdart/rxdart.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';

class FilterBloc extends BlocBase {
  final _filters = [
    "Computers",
    "Toys",
    "Health",
    "Automotive",
    "Electronics",
    "Movies",
    "Home",
    "Games",
    "Jewelery",
    "Books",
    "Grocery",
    "Music",
    "Outdoors",
  ].toSet();
  var _selectedFilters = Set<String>();

  final _subject = PublishSubject<List<String>>();

  List<String> get filters => _filters.toList();

  Observable<List<String>> get filterStream => _subject.stream;

  void toggle(String filter) {
    if (isSelected(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }
    _subject.sink.add(_selectedFilters.toList());
  }

  bool isSelected(String filter) => _selectedFilters.contains(filter);

  void clear(){
    _selectedFilters = Set<String>();
    _subject.sink.add(_selectedFilters.toList());
  }

  @override
  void dispose() {
    _subject.close();
  }
}
