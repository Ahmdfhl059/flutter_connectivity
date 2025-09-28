import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      if (event is ConnectedEvent) {
        emit(ConnectedState(message: 'Connected'));
      } else if (event is NotConnectedEvent) {
        emit(NotConnectedState(message: 'NotConnected'));
      }
    });

    _subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
            if (result == ConnectivityResult.wifi ||
                result == ConnectivityResult.mobile) {
              add(ConnectedEvent());
            } else {
              add(NotConnectedEvent());
            }
          }
          as void Function(List<ConnectivityResult> event)?,
    );
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
