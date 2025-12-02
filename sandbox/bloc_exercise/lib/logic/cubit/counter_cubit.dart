import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin{
  CounterCubit() : super(CounterState(counterValue: 0));

  void increment() => emit(
    CounterState(counterValue: state.counterValue + 1, wasIncremented: true),
  );

  void decrement() => emit(
    CounterState(counterValue: state.counterValue - 1, wasIncremented: false),
  );
  
  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
  
  @override
  Map<String, dynamic>? toJson(CounterState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
