import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

import 'test_response_models.dart';

class TestRequest1 extends RequestCommand<TestResponse1> {
  @override
  String get path => '/test1';

  @override
  TestResponse1 get sampleModel => const TestResponse1.empty();
}
