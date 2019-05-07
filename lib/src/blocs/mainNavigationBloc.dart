import 'package:rxdart/rxdart.dart';
import 'package:shopping_app/src/blocs/blocProvider.dart';

class MainNavigationBloc extends BlocBase {
  int defaultIndex = 0;
  BehaviorSubject<int> _navBarController;

  MainNavigationBloc() {
    //initializes the subject with the default index
    _navBarController = new BehaviorSubject<int>.seeded(defaultIndex);
  }

  // the stream getter
  Observable<int> get navStream => _navBarController.stream;

  //
  void navigateTo(int i) {
    _navBarController.sink.add(i);
  }

  close() {
    _navBarController?.close();
  }

  @override
  void dispose() {
    close();
  }
}
