import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

/// [ResponseModel] implementation to ignore the response data.
///
/// This can be used when the response data is not needed. For example,
/// endpoints that return no content (204).
///
/// Also useful for error responses where the response body is not relevant.
class IgnoredResponseModel extends ResponseModel {}

/// A response factory that creates an instance of [IgnoredResponseModel]
class IgnoredResponseModelFactory
    extends CustomResponseFactory<IgnoredResponseModel> {
  @override
  IgnoredResponseModel fromString(String plainString) {
    return IgnoredResponseModel();
  }
}
