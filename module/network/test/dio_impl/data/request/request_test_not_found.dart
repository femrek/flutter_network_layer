import 'package:network/network.dart';

import '../response/response_empty.dart';

class RequestTestNotFound implements IRequestCommand<ResponseEmpty> {
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
  String get path => '/not-found';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseEmpty get sampleModel => const ResponseEmpty();
}
