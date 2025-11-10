import 'dart:async';

import 'package:bloc_exercise/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((
      connectivityResult,
    ) {
      if (connectivityResult.contains(ConnectivityResult.wifi)) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (connectivityResult.contains(ConnectivityResult.mobile)) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
