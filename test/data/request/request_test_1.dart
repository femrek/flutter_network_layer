import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

import '../response/response_test_1.dart';

final class RequestTest1 extends RequestCommand<ResponseTest1> {
  @override
  String get path => '/test1';

  @override
  ResponseTest1 get sampleModel => const ResponseTest1.empty();
}
