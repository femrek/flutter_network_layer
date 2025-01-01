/// Enum for log level that can be used in the logger of the dio implementation.
enum LogLevel {
  /// Log level for trace logs.
  trace(maySensitiveData: false),

  /// The log level that is used for printing the success responses.
  successResponse(maySensitiveData: true),

  /// The log level that is used for printing the error responses.
  errorResponse(maySensitiveData: true),

  /// The log level that is used for printing the request that is prepared to
  /// be sent.
  request(maySensitiveData: true),

  /// The log level that is used for printing when the network manager is
  /// being initialized.
  init(maySensitiveData: false),

  /// The log level that is used for printing the errors that occur in the
  /// local code.
  internalError(maySensitiveData: false),
  ;

  const LogLevel({
    required this.maySensitiveData,
  });

  /// Whether the log may contain sensitive data such as Authorization header,
  /// etc.
  ///
  /// Relies on request paths and thrown errors to not contain sensitive
  /// data.
  final bool maySensitiveData;
}
