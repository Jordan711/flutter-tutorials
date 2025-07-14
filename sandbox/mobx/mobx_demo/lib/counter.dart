import 'package:mobx/mobx.dart';

// Run dart run build_runner build
// Need to manually add build_runner and mobx_codegen in pubspec.yaml
part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

abstract class CounterBase with Store {
  @observable
  int values = 0;

  @action
  void increment() {
    values++;
  }

  @action
  void reset() {
    values = 0;
  }
}
