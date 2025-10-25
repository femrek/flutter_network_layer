import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

import '../response/response_empty.dart';

class RequestTestNotFound
    extends RequestCommand<ResponseEmpty, IgnoredResponseModel> {
  @override
  String get path => '/not-found';

  @override
  final ResponseFactory<ResponseEmpty> responseFactory = ResponseEmptyFactory();

  @override
  final ResponseFactory<IgnoredResponseModel> errorResponseFactory =
      IgnoredResponseModelFactory();
}
