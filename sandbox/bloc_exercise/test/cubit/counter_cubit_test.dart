// Run tests by `pub run test`

import 'package:bloc_exercise/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // A group represents a group of tests
  group("CounterCubit", () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    // after block after each test is run
    tearDown(() {
      counterCubit.close();
    });

    test("The intitial state for the CounterCubit is CounterState(counterValue:0)", () {
      expect(counterCubit.state, CounterState(counterValue: 0));
    });
  });
}