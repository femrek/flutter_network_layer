import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// Base class to define the type of responses from the server.
///
/// [JsonResponseFactory] or [CustomResponseFactory] implementations
/// should be provided in the request command to parse the response data.
abstract class ResponseModel {
  /// const constructor to allow subclasses to be const.
  const ResponseModel();

  /// Converts the instance to a loggable string.
  ///
  /// This method is useful for logging the response data.
  ///
  /// By default, it returns the runtime type of the instance. But for better
  /// logging, it is recommended to override this method in subclasses.
  ///
  /// Used in [NetworkLogSuccessResponse.message] function.
  String toLogString() {
    return '$runtimeType';
  }
}
