/// Callback for logging Dio requests and responses.
typedef OnNetworkLog = void Function(
  NetworkLogType logType,
  String message,
);

/// Enum for log types (or log levels) that can be used in the logger of the
/// network invoker.
enum NetworkLogType {
  /// Log level for trace logs.
  trace(mayContainSensitiveData: false),

  /// The log level that is used for printing the success responses.
  successResponse(mayContainSensitiveData: true),

  /// The log level that is used for printing the error responses.
  errorResponse(mayContainSensitiveData: true),

  /// The log level that is used for printing the request that is prepared to
  /// be sent.
  request(mayContainSensitiveData: true),

  /// The log level that is used for printing when the network invoker is
  /// being initialized.
  init(mayContainSensitiveData: false),

  /// The log level that is used for printing the errors that occur in the
  /// local code.
  internalError(mayContainSensitiveData: false),
  ;

  const NetworkLogType({
    required this.mayContainSensitiveData,
  });

  /// Whether the log may contain sensitive data such as Authorization header,
  /// request body, response body, etc.
  ///
  /// Relies on request paths and thrown errors to not contain sensitive data.
  final bool mayContainSensitiveData;
}
