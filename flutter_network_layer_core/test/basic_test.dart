import 'dart:convert';

import 'package:flutter_network_layer_core/flutter_network_layer_core.dart';
import 'package:http/http.dart' as http;
import 'package:http_test_server/http_test_server.dart';
import 'package:test/test.dart';

import 'utils/test_request_samples.dart';
import 'utils/test_response_samples.dart';
import 'utils/test_server.dart' as ts;

void main() async {
  group('basic tests', () {
    test('ping-pong', () async {
      // run the server
      final server = await ts.TestServer.bindServer(onRequest: (req) {
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

      // result.when test
      final resultData = result.when(
        success: (success) {
          expect(success.data.field1, 'pong');
          return success.data;
        },
        error: (error) {
          fail('Error: ${error.message}');
        },
      );
      expect(resultData.field1, 'pong');

      // result.whenAsync test
      final resultData2 = await result.whenAsync(
        success: (success) async {
          expect(success.data.field1, 'pong');
          return success.data;
        },
        error: (error) async {
          fail('Error: ${error.message}');
        },
      );
      expect(resultData2.field1, 'pong');
    });

    test('Error Response', () async {
      // run the server
      final server = await TestServer.createHttpServer(events: [
        StandardServerEvent(
          matcher: ServerEvent.standardMatcher(paths: ['/basic_test_error']),
          handler: (request) =>
              '{"message": "Bad Request", "errorField": "error_value"}',
          responseStatusCode: 400,
        ),
        StandardServerEvent(
          matcher: ServerEvent.standardMatcher(paths: ['/basic_test']),
          handler: (request) => '{"field1": "pong"}',
        ),
      ]);

      final invoker = _SampleNetworkInvoker(port: server.port);
      await invoker.init('http://${server.address.address}');

      // error response test
      {
        final request = RequestTest1Error(field1: 'trigger_error');
        final result = await invoker.request(request);

        expect(result, isA<ErrorResponseResult>());

        // result.when test
        result.when(
          success: (success) {
            fail('Expected error but got success');
          },
          error: (error) {
            expect(error.statusCode, 400);
            final errorResponse = error.errorResponse;
            if (errorResponse == null) {
              fail('Expected error response but got null');
            }
            expect(errorResponse, isA<ResponseTestError>());
            expect(errorResponse.errorField, 'error_value');
            expect(errorResponse.message, 'Bad Request');
          },
        );
      }

      // success response test
      {
        final request = RequestTest1(field1: 'ping');
        final result = await invoker.request(request);

        expect(result, isA<SuccessResponseResult>());

        // result.when test
        result.when(
          success: (success) {
            expect(success.data.field1, 'pong');
          },
          error: (error) {
            fail('Expected success but got error');
          },
        );
      }
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
  OnNetworkLog get onLog => (_) {};

  @override
  Future<void> init(String baseUrl) async {
    this.baseUrl = '$baseUrl:$port';
  }

  @override
  Future<ResponseResult<T, E>>
      request<T extends ResponseModel, E extends ResponseModel>(
          RequestCommand<T, E> request) async {
    final response = await http.get(Uri.parse('$baseUrl${request.path}'));
    if (response.statusCode != 200) {
      return ErrorResponseResult.withResponse(
        statusCode: response.statusCode,
        errorResponse: request.errorResponseFactory.when(
          json: (JsonResponseFactory<E> json) {
            final jsonData = jsonDecode(response.body);
            final model = json.fromJson(jsonData);
            return model;
          },
          custom: (CustomResponseFactory<E> custom) {
            final model = custom.fromString(response.body);
            return model;
          },
        ),
        error: NetworkErrorResponse(
          message: 'Error: ${response.body}',
          statusCode: response.statusCode,
          stackTrace: StackTrace.current,
        ),
      );
    }

    final body = response.body;

    return request.responseFactory.when<ResponseResult<T, E>>(
      json: (JsonResponseFactory<T> json) {
        final jsonData = jsonDecode(body);
        final model = json.fromJson(jsonData);
        return SuccessResponseResult(data: model, statusCode: 200);
      },
      custom: (CustomResponseFactory<T> custom) {
        final model = custom.fromString(body);
        return SuccessResponseResult(data: model, statusCode: 200);
      },
    );
  }
}
