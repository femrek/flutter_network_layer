import 'package:flutter_network_layer/flutter_network_layer.dart';

/// Callback for logging Dio requests and responses.
typedef OnDioLog = void Function(
  LogLevel level,
  String message,
);
