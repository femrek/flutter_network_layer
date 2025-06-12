import 'package:flutter_network_layer_dart/flutter_network_layer_dart.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';
import 'package:http_test_server/http_test_server.dart';
import 'package:test/test.dart';

import 'data/request/request_test_1.dart';
import 'data/response/response_test_1.dart';

List<INetworkInvoker> _createInvokers() => <INetworkInvoker>[
      DioNetworkInvoker(),
      DartNetworkInvoker(),
    ];

void main() {
  group('Basic Test', () {
    _createInvokers().forEach((e) {
      test('Invoker: ${e.runtimeType}', () async {
        // setup server
        final server = await TestServer.createHttpServer(events: [
          StandardServerEvent(
            matcher: ServerEvent.standardMatcher(paths: ['/test1']),
            handler: (request) {
              return '{"field1": "value1"}';
            },
          ),
        ]);

        // init invoker
        await e.init('http://localhost:${server.port}');

        // send request
        final responseResult = await e.request(RequestTest1());

        final response = responseResult.when(
          success: (success) {
            expect(success.statusCode, 200);
            return success.data;
          },
          error: (error) {
            throw Exception('Error: ${error.message}');
          },
        );
        expect(response.field1, 'value1');

        await server.close(force: true);
      });
    });
  });

  group('Unresolved Host Test', () {
    _createInvokers().forEach((e) {
      test('Invoker: ${e.runtimeType}', () async {
        // init invoker with unresolved host
        await e.init('http://unresolved-host');

        // send request
        final responseResult = await e.request(RequestTest1());

        responseResult.when(
          success: (_) {
            fail('The request should fail');
          },
          error: (error) {
            expect(
              error.isFromLocal,
              isTrue,
              reason: 'The error should be from local',
            );
          },
        );
      });
    });
  });

  group('Invalid Response Type Test', () {
    _createInvokers().forEach((e) {
      test('Invoker: ${e.runtimeType}', () async {
        // setup server
        final server = await TestServer.createHttpServer(events: [
          StandardServerEvent(
            matcher: ServerEvent.standardMatcher(paths: ['/test1']),
            handler: (request) {
              return 'Invalid JSON';
            },
          ),
        ]);

        // init invoker
        await e.init('http://localhost:${server.port}');

        // send request
        final responseResult = await e.request(RequestTest1());

        responseResult.when(
          success: (_) {
            fail('The request should fail');
          },
          error: (error) {
            expect(error, isA<ErrorResponseResult<ResponseTest1>>());
          },
        );

        await server.close(force: true);
      });
    });
  });

  group('Network Error Response Test', () {
    _createInvokers().forEach((e) {
      test('Invoker: ${e.runtimeType}', () async {
        // setup server
        final server = await TestServer.createHttpServer(events: [
          StandardServerEvent(
            matcher: ServerEvent.standardMatcher(paths: ['/test1']),
            handler: (request) {
              return 'Not Found';
            },
            responseStatusCode: 404,
          ),
        ]);

        // init invoker
        await e.init('http://localhost:${server.port}');

        // send request
        final responseResult = await e.request(RequestTest1());

        responseResult.when(
          success: (_) {
            fail('The request should fail');
          },
          error: (error) {
            expect(error, isA<ErrorResponseResult<ResponseTest1>>());
            expect(error.statusCode, 404);
          },
        );

        await server.close(force: true);
      });
    });
  });
}
