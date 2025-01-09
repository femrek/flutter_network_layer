import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class ResponseEmpty extends JsonResponseModel {
  const ResponseEmpty();

  @override
  ResponseEmpty fromJson(dynamic json) => const ResponseEmpty();

  @override
  List<void> toJson() => const [];
}
