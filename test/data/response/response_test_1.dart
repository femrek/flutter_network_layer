import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

final class ResponseTest1 extends JsonResponseModel {
  const ResponseTest1({
    required this.field1,
  });

  const ResponseTest1.empty() : field1 = '';

  final String field1;

  @override
  JsonResponseModel fromJson(dynamic json) {
    if (json == null) {
      throw Exception('Json is null: $json');
    }
    if (json is! Map<String, dynamic>) {
      throw Exception('Json is not a Map: $json');
    }

    final field1 = json['field1'] as String?;
    if (field1 == null) {
      throw Exception('Field1 is null: $field1');
    }

    return ResponseTest1(field1: field1);
  }

  @override
  dynamic toJson() {
    return {
      'field1': field1,
    };
  }
}
