import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

final class ResponseTest1 extends ResponseModel {
  ResponseTest1({required this.field1});

  final String field1;

  @override
  String toLogString() {
    return 'ResponseTest1(field1: $field1)';
  }
}

class ResponseTest1Factory extends JsonResponseFactory<ResponseTest1> {
  factory ResponseTest1Factory() => _instance;

  ResponseTest1Factory._internal();

  static final ResponseTest1Factory _instance =
      ResponseTest1Factory._internal();

  @override
  ResponseTest1 fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw Exception('Invalid JSON: $json');
    }
    return ResponseTest1(
      field1: json['field1'] as String,
    );
  }
}
