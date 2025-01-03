import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class ResponseEmpty implements IResponseModel {
  const ResponseEmpty();

  @override
  IResponseModel fromJson(dynamic json) => const ResponseEmpty();

  @override
  List<void> toJson() => const [];
}
