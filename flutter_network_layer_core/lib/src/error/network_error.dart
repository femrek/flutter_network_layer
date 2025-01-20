/// The base class for errors that occur in the invokers of this package.
///
/// This classes are used to log internal errors or
sealed class NetworkErrorBase {
  const NetworkErrorBase({
    required this.message,
    required this.stackTrace,
    this.error,
  });

  /// The explanation of the error.
  final String message;

  /// The stack trace of the point where the error is thrown.
  final StackTrace stackTrace;

  /// The thrown error object if it is forwarding.
  final Object? error;
}

/// The error type for errors for returned non-successful responses. (404 etc.)
final class NetworkErrorResponse extends NetworkErrorBase {
  /// Creates a network error response.
  const NetworkErrorResponse({
    required this.statusCode,
    required super.message,
    required super.stackTrace,
    super.error,
  });

  /// The status code returned from the server.
  final int statusCode;

  @override
  String toString() {
    return 'NetworkErrorResponse($statusCode): $message';
  }
}

/// The error type for errors occurred in the network invoker about the response
/// type.
final class NetworkErrorInvalidResponseType extends NetworkErrorBase {
  /// Creates a network error response.
  NetworkErrorInvalidResponseType({
    required super.message,
    required super.stackTrace,
    super.error,
  });

  @override
  String toString() {
    return 'NetworkErrorInvalidResponseType: $message';
  }
}

/// The error type for general type of errors occurred in the network invoker.
final class NetworkError extends NetworkErrorBase {
  /// Creates a network error.
  const NetworkError({
    required super.message,
    required super.stackTrace,
    super.error,
  });

  @override
  String toString() {
    return 'NetworkError: $message';
  }
}
