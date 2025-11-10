import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_exercise/constants/enums.dart';
import 'package:bloc_exercise/logic/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetStreamSubscription;

  CounterCubit({required this.internetCubit})
    : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  void monitorInternetCubit() {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.wifi) {
        increment();
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.mobile) {
        decrement();
      }
    });
  }

  void increment() => emit(
    CounterState(counterValue: state.counterValue + 1, wasIncremented: true),
  );

  void decrement() => emit(
    CounterState(counterValue: state.counterValue - 1, wasIncremented: false),
  );

  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
