import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_quest/features/network/data/repository/network_repository.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_event.dart';
import 'package:habit_quest/features/network/presentation/bloc/network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState>
    with WidgetsBindingObserver {
  NetworkBloc({required this.networkCheckRepository})
      : super(NetworkLoading()) {
    // Start observing app lifecycle
    WidgetsBinding.instance.addObserver(this);

    // Start listening to network status changes
    _startConnectionCheck();

    // Handle the NetworkConnectedEvent and NetworkDisconnectedEvent
    on<NetworkConnectedEvent>((event, emit) {
      emit(NetworkConnected());
    });

    on<NetworkDisconnectedEvent>((event, emit) {
      emit(NetworkDisconnected());
    });
  }

  final NetworkRepository networkCheckRepository;
  StreamSubscription<bool>? _networkSubscription;

  void _startConnectionCheck() {
    _networkSubscription =
        networkCheckRepository.connectionStatusStream.listen((hasInternet) {
      if (hasInternet) {
        add(NetworkConnectedEvent());
      } else {
        add(NetworkDisconnectedEvent());
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Restart connection check when app resumes
      _startConnectionCheck();
    } else if (state == AppLifecycleState.paused) {
      // Stop the subscription when the app is paused
      _networkSubscription?.cancel();
    }
  }

  @override
  Future<void> close() {
    // Clean up observer
    WidgetsBinding.instance.removeObserver(this);
    // Clean up the subscription
    _networkSubscription?.cancel();
    return super.close();
  }
}
