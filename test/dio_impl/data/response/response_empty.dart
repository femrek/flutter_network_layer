import 'package:flutter_network_layer/flutter_network_layer.dart';

class ResponseEmpty implements IResponseModel {
  const ResponseEmpty();

  @override
  IResponseModel fromJson(dynamic json) => const ResponseEmpty();

  @override
  List<void> toJson() => const [];
}
