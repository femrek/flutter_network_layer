import 'dart:async';

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// Base type of factory that creates instances of [ResponseModel].
sealed class ResponseFactory<T extends ResponseModel> {
  /// const constructor to allow subclasses to be const.
  const ResponseFactory();

  /// Executes the given function based on the type of the factory.
  ///
  /// See also [whenAsync].
  R when<R>({
    required R Function(JsonResponseFactory<T> response) json,
    required R Function(CustomResponseFactory<T> response) custom,
  }) {
    switch (this) {
      case final JsonResponseFactory<T> f:
        return json(f);
      case final CustomResponseFactory<T> f:
        return custom(f);
    }
  }

  /// Executes the given async/sync function based on the type of the factory.
  ///
  /// This is an asynchronous version of [when]. Allows to execute an async
  /// process and wait for the result.
  Future<R> whenAsync<R>({
    required FutureOr<R> Function(JsonResponseFactory<T> response) json,
    required FutureOr<R> Function(CustomResponseFactory<T> response) custom,
  }) async {
    switch (this) {
      case final JsonResponseFactory<T> f:
        return await json(f);
      case final CustomResponseFactory<T> f:
        return await custom(f);
    }
  }
}

/// A factory that creates instances of [ResponseModel] from JSON data.
///
/// If the expected response is json, then [JsonResponseFactory] should be
/// used.
///
/// The invoker uses this class to convert the response body to the expected
/// type.
abstract class JsonResponseFactory<T extends ResponseModel>
    extends ResponseFactory<T> {
  /// const constructor to allow subclasses to be const.
  const JsonResponseFactory();

  /// Converts the map or list to an instance.
  ///
  /// The [json] parameter is the decoded json data, which can be a [Map] or a
  /// [List].
  T fromJson(dynamic json);
}

/// A factory that creates instances of [ResponseModel] from raw data.
///
/// If the expected response is not json, then [CustomResponseFactory] should be
/// used.
abstract class CustomResponseFactory<T extends ResponseModel>
    extends ResponseFactory<T> {
  /// const constructor to allow subclasses to be const.
  const CustomResponseFactory();

  /// Converts the plain string to an instance.
  ///
  /// The [plainString] parameter is the raw response body as a string.
  T fromString(String plainString);
}
