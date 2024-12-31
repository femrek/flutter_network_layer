/// Enum for log level that can be used in the logger of the application.
enum LogLevel {
  /// Trace log level. Used for logging at the start and end of functions.
  trace('TRACE'),

  /// Debug log level. Used for logging detailed information.
  debug('DEBUG'),

  /// Info log level. Used for logging general information. (e.g.
  /// initializations)
  info('INFO'),

  /// Warn log level. Used for logging warnings.
  warn('WARN'),

  /// Error log level. Used for logging errors that should not occur.
  error('ERROR'),

  /// Fatal log level. Used for logging errors that cannot be recovered from.
  fatal('FATAL'),
  ;

  const LogLevel(this.name);

  /// The name of the log level.
  final String name;
}
