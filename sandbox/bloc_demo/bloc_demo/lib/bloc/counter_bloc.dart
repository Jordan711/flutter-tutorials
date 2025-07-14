import 'package:bloc_demo/bloc/counter_event.dart';
import 'package:bloc_demo/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<Increment>((event, emit) {
      emit(CounterValue(state.value + 1));
    });

    on<Decrement>((event, emit) {
      emit(CounterValue(state.value - 1));
    });
  }
}
