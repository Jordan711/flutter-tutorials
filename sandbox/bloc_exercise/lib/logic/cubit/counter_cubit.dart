import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends HydratedCubit<CounterState> {
  CounterCubit() : super(CounterState(counterValue: 0));

  void increment() => emit(
    CounterState(counterValue: state.counterValue + 1, wasIncremented: true),
  );

  void decrement() => emit(
    CounterState(counterValue: state.counterValue - 1, wasIncremented: false),
  );

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    // Called every time the app needs stored data
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    // Called for every state
    return state.toMap();
  }
}
