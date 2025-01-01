import 'package:equatable/equatable.dart';

abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object?> get props => [];
}

class NetworkConnectedEvent extends NetworkEvent {}

class NetworkDisconnectedEvent extends NetworkEvent {}
