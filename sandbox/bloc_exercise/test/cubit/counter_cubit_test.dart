// Run tests by `pub run test`

import 'package:bloc_exercise/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
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

    test(
      "The intitial state for the CounterCubit is CounterState(counterValue:0)",
      () {
        // Two instances are each stored in different memory addresses
        // Dart compares their location in memory so need to use Equatable
        // It compares instances by value rather than their memory locations
        expect(counterCubit.state, CounterState(counterValue: 0));
      },
    );

    blocTest(
      "The cubit should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() function is called",
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest(
      "The cubit should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.decrement() function is called",
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
