import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProvider =
    ChangeNotifierProvider<CounterViewModel>((ref) => CounterViewModel());

// Autodispose allows the provider to be disposed of when it is not in use
// This resets the state when you, say go to a different screen

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  void add() {
    _counter++;
    notifyListeners();
  }
}
