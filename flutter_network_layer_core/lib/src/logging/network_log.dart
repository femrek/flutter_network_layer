import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';
import 'package:flutter_network_layer_core/src/logging/log_utils.dart';

/// Callback for logging Dio requests and responses.
typedef OnNetworkLog = void Function(NetworkLog log);

/// Enum for log types (or log levels) that can be used in the logger of the
/// network invoker.
sealed class NetworkLog {
  NetworkLog({
    StackTrace? stackTrace,
  }) {
    this.stackTrace = stackTrace ?? StackTrace.current;
  }

  /// The stack trace of the log. Can be set manually or set as the current
  /// stack trace.
  late final StackTrace stackTrace;

  /// The type of the log. Can be used to print the category of the log.
  String get type;

  /// The content of the log. Can be used to print the log message.
  String get message;
}

/// Log type for trace logs.
final class NetworkLogTrace extends NetworkLog with LogUtils {
  /// Creates a trace log that is start of a function.
  NetworkLogTrace.start({
    String? message,
  })  : _start = true,
        _message = message;

  /// Creates a trace log that is end of a function.
  NetworkLogTrace.end({
    String? message,
  })  : _start = false,
        _message = message;

  /// Creates a trace log that is unspecified if it is start or end of a
  /// function.
  NetworkLogTrace.unspecified({
    String? message,
  })  : _start = null,
        _message = message;

  final bool? _start;

  final String? _message;

  @override
  String get type => 'TRACE';

  @override
  String get message {
    late final String prefix;
    if (_start == null) {
      prefix = 'TRACE';
    } else {
      prefix = _start ? 'START' : 'END  ';
    }

    final buffer = StringBuffer('$prefix:'
        ' ${callerFunction(stackTrace: stackTrace, dept: 3)}');
    if (_message != null) buffer.write(': $_message');
    return buffer.toString();
  }
}

/// The log type that is used for printing the success responses.
final class NetworkLogSuccessResponse<T extends ResponseModel>
    extends NetworkLog {
  /// Creates a success response log.
  ///
  /// [statusCode] is the status code of the response. [data] is the payload of
  /// the response. It must be an [ResponseModel] and not null. An empty
  /// response model can be used if there is no data.
  NetworkLogSuccessResponse({
    required this.statusCode,
    required this.data,
    super.stackTrace,
  });

  /// The status code of the response.
  final int statusCode;

  /// The payload of the response.
  final T data;

  @override
  String get message => 'Response Succeeded: $statusCode ${data.toLogString()}';

  @override
  String get type => 'RES_S';
}

/// The log type that is used for printing the error responses.
final class NetworkLogErrorResponse extends NetworkLog {
  /// Creates an error response log.
  ///
  /// [statusCode] is the status code of the response. [errorMessage] is the
  /// error message of the response.
  NetworkLogErrorResponse({
    required this.statusCode,
    required this.errorMessage,
    super.stackTrace,
  });

  /// The status code of the response.
  final int statusCode;

  /// The error message of the response.
  final String errorMessage;

  @override
  String get type => 'RES_E';

  @override
  String get message => 'Response Failed: $statusCode $errorMessage';
}

/// The log type that is used for printing the request logs.
final class NetworkLogRequest extends NetworkLog {
  /// Creates a request log.
  ///
  /// [request] is the request command that is used to create the request.
  NetworkLogRequest({
    required this.request,
    super.stackTrace,
  });

  /// The request command that is used to create the request.
  final RequestCommand request;

  @override
  String get type => 'REQ';

  @override
  String get message => 'Request: ${request.toLogString()}';
}

/// The log type that is used for printing when the network invoker is being
/// initialized.
final class NetworkLogInit extends NetworkLog {
  /// Creates an init log.
  NetworkLogInit({
    required this.baseUrl,
    this.additionalMessage,
    super.stackTrace,
  });

  /// The base URL of the network invoker.
  final String baseUrl;

  /// Additional message that can be added to the log.
  final String? additionalMessage;

  @override
  String get type => 'INIT';

  @override
  String get message {
    final buffer =
        StringBuffer('Network Invoker Initialized with Base URL: $baseUrl');
    if (additionalMessage != null) {
      buffer.write('Additional Message: $additionalMessage');
    }
    return buffer.toString();
  }
}

/// The log type that is used for printing the errors that occur in the local
/// code.
final class NetworkLogInternalError extends NetworkLog {
  /// Creates an internal error log.
  NetworkLogInternalError({
    required this.error,
    super.stackTrace,
  });

  /// The error that is thrown in the local code.
  final Object error;

  @override
  String get type => 'ERROR';

  @override
  String get message => 'Internal Error: $error\n$stackTrace';
}

/// The log type that is used for printing custom logs that is not specified in
/// the `flutter_network_layer_core` package.
final class NetworkLogCustom extends NetworkLog {
  /// Creates a custom log.
  ///
  /// [type] is the type of the log that corresponds to log level. [message] is
  /// the content of the log.
  NetworkLogCustom({
    required this.type,
    required this.message,
    super.stackTrace,
  });

  @override
  final String type;

  @override
  final String message;
}
