import 'dart:async';

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// The standard response result of a request. [T] is the type of the success
/// response model and [E] is the type of the error response model.
sealed class ResponseResult<T extends ResponseModel, E extends ResponseModel> {
  /// The payload of the response.
  int? get statusCode;

  /// Returns true if the response is a success, otherwise false.
  bool get isSuccess;

  /// Get the instance as [SuccessResponseResult] only if it is a success.
  /// Otherwise, it will throw an exception.
  SuccessResponseResult<T, E> get asSuccess {
    assert(isSuccess, 'The response is not a success response.');
    return this as SuccessResponseResult<T, E>;
  }

  /// If the instance is an error response, otherwise it will throw an
  /// exception.
  ErrorResponseResult<T, E> get asError {
    assert(!isSuccess, 'The response is not an error response.');
    return this as ErrorResponseResult<T, E>;
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
  R when<R>({
    required R Function(SuccessResponseResult<T, E> response) success,
    required R Function(ErrorResponseResult<T, E> response) error,
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
  Future<R> whenAsync<R>({
    required FutureOr<R> Function(SuccessResponseResult<T, E> response) success,
    required FutureOr<R> Function(ErrorResponseResult<T, E> response) error,
  }) async {
    if (isSuccess) {
      return await success(asSuccess);
    } else {
      return await error(asError);
    }
  }
}

/// The standard response result of a request.
final class SuccessResponseResult<T extends ResponseModel,
    E extends ResponseModel> extends ResponseResult<T, E> {
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
final class ErrorResponseResult<T extends ResponseModel,
    E extends ResponseModel> extends ResponseResult<T, E> {
  /// Creates an error response result, if a response is received from the
  /// server.
  ///
  /// [message] is the error message. It must not be null. [statusCode] is the
  /// status code of the response. It must not be null for server errors.
  ErrorResponseResult.withResponse({
    required this.error,
    required this.errorResponse,
    required int this.statusCode,
  });

  /// Creates an error response result, if a response is not received from the
  /// server. For example, no internet connection.
  ///
  /// [message] is the error message. It must not be null.
  ErrorResponseResult.noResponse({
    required this.error,
  })  : statusCode = null,
        errorResponse = null;

  /// The error response payload of the response, if any.
  final E? errorResponse;

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
