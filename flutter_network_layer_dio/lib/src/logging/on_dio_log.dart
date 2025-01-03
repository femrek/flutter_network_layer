import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// Callback for logging Dio requests and responses.
typedef OnDioInvokerLog = void Function(
  LogLevel level,
  String message,
);
