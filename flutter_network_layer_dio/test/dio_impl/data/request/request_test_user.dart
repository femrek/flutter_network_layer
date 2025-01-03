import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

import '../response/response_test_user.dart';
import '../test_paths.dart';

class RequestTestUser implements IRequestCommand<ResponseTestUser> {
  @override
  Map<String, dynamic> get data => const {};

  @override
  Map<String, dynamic> get headers => const {};

  @override
  HttpRequestMethod get method => HttpRequestMethod.get;

  @override
  OnProgressCallback? onReceiveProgressUpdate;

  @override
  OnProgressCallback? onSendProgressUpdate;

  @override
  String get path => TestPaths.testUser;

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseTestUser get sampleModel => const ResponseTestUser.empty();
}
