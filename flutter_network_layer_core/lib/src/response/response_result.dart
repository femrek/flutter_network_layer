import 'dart:async';

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// The standard response result of a request.
sealed class ResponseResult<T extends ResponseModel> {
  /// The payload of the response.
  int? get statusCode;

  /// Returns true if the response is a success, otherwise false.
  bool get isSuccess;

  /// Get the instance as [SuccessResponseResult] only if it is a success.
  /// Otherwise, it will throw an exception.
  SuccessResponseResult<T> get asSuccess {
    assert(isSuccess, 'The response is not a success response.');
    return this as SuccessResponseResult<T>;
  }

  /// If the instance is an error response, otherwise it will throw an
  /// exception.
  ErrorResponseResult<T> get asError {
    assert(!isSuccess, 'The response is not an error response.');
    return this as ErrorResponseResult<T>;
  }

  /// Executes the given function based on the type of the response.
  ///
  /// If the response is a success, [success] function will be executed
  /// otherwise [error] function will be executed
  ///
  /// Optionally, this function can return a value that is returned by error or
  /// success functions.
  ///
  /// See also [whenAsync].
  E when<E>({
    required E Function(SuccessResponseResult<T> response) success,
    required E Function(ErrorResponseResult<T> response) error,
  }) {
    if (isSuccess) {
      return success(asSuccess);
    } else {
      return error(asError);
    }
  }

  /// Executes the given async/sync function based on the type of the response.
  ///
  /// If the response is a success, [success] function will be executed
  /// otherwise [error] function will be executed
  ///
  /// Optionally, this function can return a value that is returned by error or
  /// success functions.
  ///
  /// This is an asynchronous version of [when]. Allows to execute an async
  /// process and wait for the result.
  Future<E> whenAsync<E>({
    required FutureOr<E> Function(SuccessResponseResult<T> response) success,
    required FutureOr<E> Function(ErrorResponseResult<T> response) error,
  }) async {
    if (isSuccess) {
      return await success(asSuccess);
    } else {
      return await error(asError);
    }
  }
}

/// The standard response result of a request.
final class SuccessResponseResult<T extends ResponseModel>
    extends ResponseResult<T> {
  /// Creates a success response result.
  ///
  /// [data] is the payload of the response. It must be an [ResponseModel] and
  /// not null. An empty response model can be used if there is no data.
  /// [statusCode] is the status code of the response. Mostly, it is 200 for
  /// success responses.
  SuccessResponseResult({
    required this.data,
    required this.statusCode,
  });

  /// The payload of the response.
  final T data;

  @override
  final int statusCode;

  @override
  bool get isSuccess => true;
}

/// The error response result of a request.
final class ErrorResponseResult<T extends ResponseModel>
    extends ResponseResult<T> {
  /// Creates an error response result, if a response is received from the
  /// server.
  ///
  /// [message] is the error message. It must not be null. [statusCode] is the
  /// status code of the response. It must not be null for server errors.
  ErrorResponseResult.withResponse({
    required this.error,
    required int this.statusCode,
  });

  /// Creates an error response result, if a response is not received from the
  /// server. For example, no internet connection.
  ///
  /// [message] is the error message. It must not be null.
  ErrorResponseResult.noResponse({
    required this.error,
  }) : statusCode = null;

  /// The error message of the response.
  String get message => error.message;

  /// Returns true if the error is from the server, otherwise false.
  ///
  /// Also see [isFromLocal].
  bool get isFromServer => statusCode != null;

  /// Returns true if the error is from the local device, otherwise false.
  ///
  /// Also see [isFromServer].
  bool get isFromLocal => statusCode == null;

  /// The error that caused the failure.
  NetworkErrorBase error;

  @override
  final int? statusCode;

  @override
  bool get isSuccess => false;
}
