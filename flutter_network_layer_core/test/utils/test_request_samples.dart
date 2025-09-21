import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

import 'test_response_samples.dart';

final class RequestTest1 extends RequestCommand<ResponseTest1> {
  RequestTest1({
    required this.field1,
  });

  final String field1;

  @override
  Map<String, dynamic> get payload => {
        'field1': field1,
      };

  @override
  String get path => '/basic_test';

  @override
  final ResponseTest1Factory responseFactory = ResponseTest1Factory();
}
