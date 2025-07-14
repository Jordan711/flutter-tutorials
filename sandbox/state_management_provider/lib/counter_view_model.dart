import 'package:flutter/material.dart';

class CounterViewModel with ChangeNotifier {
  int _counter = 0;
  // Getter methods are used to retrieve a particular class field
  int get count => _counter;

  void increment() {
    _counter++;
    // Listeners are the widgets that have subscribed to the
    // state of the counter variable
    notifyListeners();
  }
}
