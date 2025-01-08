import 'dart:convert';

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'utils/test_request_samples.dart';
import 'utils/test_server.dart';

void main() async {
  group('basic tests', () {
    test('ping-pong', () async {
      // run the server
      final server = await TestServer.bindServer(onRequest: (req) {
        expect(req.method, 'GET');
        expect(req.uri.path, '/basic_test');
        req.response
          ..statusCode = 200
          ..write('{"field1": "pong"}')
          ..close();
      });

      final invoker = _SampleNetworkInvoker(port: server.port);
      await invoker.init('http://${server.address.address}');

      final request = RequestTest1(field1: 'ping');
      final result = await invoker.request(request);

      expect(result, isA<SuccessResponseResult>());
      result.when(
        success: (success) {
          expect(success.data.field1, 'pong');
        },
        error: (error) {
          fail('Error: ${error.message}');
        },
      );
    });
  });
}

class _SampleNetworkInvoker implements INetworkInvoker {
  _SampleNetworkInvoker({
    required this.port,
  });

  final int port;
  late final String baseUrl;

  @override
  Future<void> init(String baseUrl) async {
    this.baseUrl = '$baseUrl:$port';
  }

  @override
  Future<ResponseResult<T>> request<T extends ResponseModel>(
      RequestCommand<T> request) async {
    final response = await http.get(Uri.parse('$baseUrl${request.path}'));
    if (response.statusCode != 200) {
      return ErrorResponseResult.withResponse(
        message: 'Error: ${response.body}',
        statusCode: response.statusCode,
      );
    }

    final body = response.body;

    final sampleModel = request.sampleModel;
    if (sampleModel is CustomResponseModel) {
      final model = sampleModel.fromString(body) as T;
      return SuccessResponseResult(data: model, statusCode: 200);
    } else if (sampleModel is JsonResponseModel) {
      final json = jsonDecode(body);
      final model = sampleModel.fromJson(json) as T;
      return SuccessResponseResult(data: model, statusCode: 200);
    } else {
      return ErrorResponseResult.withResponse(
        message: 'Error: Invalid response model',
        statusCode: response.statusCode,
      );
    }
  }
}
