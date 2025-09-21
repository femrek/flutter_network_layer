// ignore_for_file: avoid_print just an example

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';

void main() async {
  final networkManager = NetworkManager();
  await networkManager.init('https://example.com');

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
  Future<ResponseResult<T>> request<T extends ResponseModel>(
      RequestCommand<T> request) async {
    final dummyResponseJson = <String, dynamic>{'message': 'Hello, World!'};

    return request.responseFactory.when<ResponseResult<T>>(
      json: (JsonResponseFactory<T> json) {
        final dummyResponse = json.fromJson(dummyResponseJson);
        return SuccessResponseResult(
          statusCode: 200,
          data: dummyResponse,
        );
      },
      custom: (CustomResponseFactory<T> custom) {
        return ErrorResponseResult.noResponse(
          error: NetworkErrorInvalidResponseType(
            message: 'The sample model is not a JSON response model.',
            stackTrace: StackTrace.current,
          ),
        );
      },
    );
  }

  @override
  OnNetworkLog get onLog => _onLog;

  void _onLog(NetworkLog log) {
    print('${log.type}: ${log.message}');
  }
}

class RequestExample implements RequestCommand<ResponseExample> {
  @override
  Map<String, dynamic> get payload => const {};

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
  RequestPayloadType get payloadType => RequestPayloadType.other;

  @override
  final ResponseFactory<ResponseExample> responseFactory =
      ResponseExampleFactory();

  @override
  String toString() {
    return 'RequestExample{path: $path, '
        'method: $method, '
        'payloadType: $payloadType, '
        'data: $payload, '
        'headers: $headers, '
        'onSendProgressUpdate: $onSendProgressUpdate, '
        'onReceiveProgressUpdate: $onReceiveProgressUpdate, '
        'responseFactory: $responseFactory}';
  }

  @override
  String toLogString() {
    return 'RequestExample GET $path '
        'Payload Type: $payloadType '
        'Headers: $headers '
        'Data: $payload';
  }
}

class ResponseExample extends ResponseModel {
  const ResponseExample({required this.message});

  const ResponseExample.empty() : message = '';

  final String message;

  @override
  String toString() {
    return 'ResponseExample{message: $message}';
  }
}

class ResponseExampleFactory extends JsonResponseFactory<ResponseExample> {
  factory ResponseExampleFactory() => _instance;

  const ResponseExampleFactory._internal();

  static const ResponseExampleFactory _instance =
      ResponseExampleFactory._internal();

  @override
  ResponseExample fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw ArgumentError.value(json, 'json', 'The value is not a map.');
    }

    return ResponseExample(message: json['message'] as String);
  }
}
