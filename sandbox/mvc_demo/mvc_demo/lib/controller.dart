import 'package:mvc_demo/model.dart';

class Controller {
  final Model _model;

  Controller(this._model);

  int get counter => _model.counter;

  void incrementCounter() {
    _model.incrementCounter();
  }
}