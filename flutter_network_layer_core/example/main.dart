import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

void main() async {
  final networkManager = NetworkManager();
  networkManager.init('https://example.com');

  final response = await networkManager.request(RequestExample());
  response.when(
    success: (response) {
      print(response.data.message);
    },
    error: (response) {
      print('Error: ${response.message}');
    },
  );
}

/// A dummy network manager that returns a dummy response.
class NetworkManager implements INetworkInvoker {
  @override
  Future<void> init(String baseUrl) async {}

  @override
  Future<ResponseResult<T>> request<T extends IResponseModel>(
      IRequestCommand<T> request) async {
    final dummyResponseJson = <String, dynamic>{'message': 'Hello, World!'};
    final dummyResponse = request.sampleModel.fromJson(dummyResponseJson) as T;
    return SuccessResponseResult(
      statusCode: 200,
      data: dummyResponse,
    );
  }
}

class RequestExample implements IRequestCommand<ResponseExample> {
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
  String get path => '/example';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseExample get sampleModel => const ResponseExample.empty();

  @override
  String toString() {
    return 'RequestExample{path: $path, '
        'method: $method, '
        'payloadType: $payloadType, '
        'data: $data, '
        'headers: $headers, '
        'onSendProgressUpdate: $onSendProgressUpdate, '
        'onReceiveProgressUpdate: $onReceiveProgressUpdate, '
        'sampleModel: $sampleModel}';
  }
}

class ResponseExample implements IResponseModel {
  const ResponseExample({required this.message});

  const ResponseExample.empty() : message = '';

  final String message;

  @override
  Map<String, dynamic> toJson() =>
      {
        'message': message,
      };

  @override
  IResponseModel fromJson(dynamic json) {
    return ResponseExample(message: json['message'] as String);
  }

  @override
  String toString() {
    return 'ResponseExample instance';
  }
}
