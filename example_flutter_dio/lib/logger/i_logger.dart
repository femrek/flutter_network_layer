/// Interface for app logger.
abstract interface class ILogger {
  /// Print log in level of TRACE.
  void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Print log in level of DEBUG.
  void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Print log in level of INFO.
  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Print log in level of WARNING.
  void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Print log in level of ERROR.
  void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Print log in level of FATAL.
  void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  });
}
