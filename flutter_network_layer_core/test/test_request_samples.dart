import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

import 'test_response_samples.dart';

final class RequestTest1 implements IRequestCommand<ResponseTest1> {
  RequestTest1({
    required this.field1,
  });

  final String field1;

  @override
  Map<String, dynamic> get data => {
        'field1': field1,
      };

  @override
  Map<String, dynamic> get headers => const {};

  @override
  HttpRequestMethod get method => HttpRequestMethod.get;

  @override
  OnProgressCallback? onReceiveProgressUpdate;

  @override
  OnProgressCallback? onSendProgressUpdate;

  @override
  String get path => '/basic_test';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseTest1 get sampleModel => const ResponseTest1.empty();
}
