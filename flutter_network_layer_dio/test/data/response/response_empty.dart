import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class ResponseEmpty extends ResponseModel {
  const ResponseEmpty();
}

class ResponseEmptyFactory extends JsonResponseFactory<ResponseEmpty> {
  factory ResponseEmptyFactory() => _instance;

  const ResponseEmptyFactory._internal();

  static const ResponseEmptyFactory _instance =
      ResponseEmptyFactory._internal();

  @override
  ResponseEmpty fromJson(dynamic json) => const ResponseEmpty();
}
