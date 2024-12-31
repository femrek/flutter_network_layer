import 'package:network/src/dio_impl/logging/log_level.dart';

/// Callback for logging Dio requests and responses.
typedef OnDioLog = void Function(
  LogLevel level,
  String message,
);
