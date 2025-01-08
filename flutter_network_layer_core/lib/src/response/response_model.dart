import 'dart:async';

/// Base class to define the type of responses from the server.
///
/// [JsonResponseModel] and [CustomResponseModel] are the only classes that
/// are inherited from this class yet.
sealed class ResponseModel {
  /// const constructor to allow subclasses to be const.
  const ResponseModel();

  /// Executes the given function based on the type of the model.
  ///
  /// See also [whenAsync].
  void when({
    required void Function(JsonResponseModel response) json,
    required void Function(CustomResponseModel response) custom,
  }) {
    if (this is JsonResponseModel) {
      json(this as JsonResponseModel);
    } else if (this is CustomResponseModel) {
      custom(this as CustomResponseModel);
    } else {
      throw UnimplementedError('Unknown response model type.');
    }
  }

  /// Executes the given async/sync function based on the type of the model.
  ///
  /// This is an asynchronous version of [when]. Allows to execute an async
  /// process and wait for the result.
  Future<void> whenAsync({
    required FutureOr<void> Function(JsonResponseModel response) json,
    required FutureOr<void> Function(CustomResponseModel response) custom,
  }) async {
    if (this is JsonResponseModel) {
      await json(this as JsonResponseModel);
    } else if (this is CustomResponseModel) {
      await custom(this as CustomResponseModel);
    } else {
      throw UnimplementedError('Unknown response model type.');
    }
  }
}

/// Interface for JSON responses from the server.
///
/// If the expected response is a [JsonResponseModel] implementation, then
/// the `request` function of the invoker probably uses jsonDecoder to convert
/// the response to the expected type.
abstract class JsonResponseModel extends ResponseModel {
  /// const constructor to allow subclasses to be const.
  const JsonResponseModel();

  /// Converts the instance to a map or list.
  dynamic toJson();

  /// Converts the map or list to an instance.
  JsonResponseModel fromJson(dynamic json);
}

/// Interface for responses from the server.
///
/// If the expected response is a [CustomResponseModel] implementation, then
/// the `request` function of the invoker should call the [fromString] method
/// to convert the response to the expected type. So, this type is useful for
/// custom response models that are not JSON. Check [JsonResponseModel] to
/// handle JSON responses.
abstract class CustomResponseModel extends ResponseModel {
  /// const constructor to allow subclasses to be const.
  const CustomResponseModel();

  /// Converts the instance to a plain string.
  String toPlainString();

  /// Converts the plain string to an instance.
  CustomResponseModel fromString(String plainString);
}
