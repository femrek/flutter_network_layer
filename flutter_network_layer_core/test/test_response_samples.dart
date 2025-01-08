import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

final class ResponseTest1 implements IResponseModel {
  const ResponseTest1({required this.field1});

  const ResponseTest1.empty() : field1 = '';

  final String field1;

  @override
  IResponseModel fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw Exception('Invalid JSON: $json');
    }
    return ResponseTest1(
      field1: json['field1'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'field1': field1,
    };
  }
}
