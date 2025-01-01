import 'package:network/network.dart';

/// Callback for logging Dio requests and responses.
typedef OnDioLog = void Function(
  LogLevel level,
  String message,
);
