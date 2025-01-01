// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkRepository {
  final InternetConnection _connectionChecker = InternetConnection();

  Stream<bool> get connectionStatusStream async* {
    await for (final status in _connectionChecker.onStatusChange) {
      yield status == InternetStatus.connected;
    }
  }
}
