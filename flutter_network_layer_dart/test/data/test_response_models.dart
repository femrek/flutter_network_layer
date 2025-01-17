import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

class TestResponse1 extends JsonResponseModel {
  const TestResponse1(this.field1);

  const TestResponse1.empty() : field1 = '';

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
      throw Exception('Json does not contain field1: $json');
    }
    return TestResponse1(field1);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'field1': field1,
    };
  }
}
