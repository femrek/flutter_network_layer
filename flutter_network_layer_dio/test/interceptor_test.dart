import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';
import 'package:http_test_server/http_test_server.dart';
import 'package:test/test.dart';

import 'data/request/request_test_not_found.dart';
import 'data/request/request_test_user.dart';
import 'data/response/response_test_user.dart';
import 'data/test_paths.dart';

void main() async {
  group('DioNetworkInvoker interceptor test', () {
    test('onRequest and onResponse', () async {
      final server = await TestServer.createHttpServer(events: [
        StandardServerEvent(
          matcher: ServerEvent.standardMatcher(paths: [TestPaths.testUser]),
          handler: (request) => '{"id": "1", "name": "test", "age": 20}',
        ),
      ]);

      var onRequestRun = false;
      var onResponseRun = false;

      final request = RequestTestUser();
      final networkManager = DioNetworkInvoker(
        onLog: _onLog,
        dioInterceptors: [
          InterceptorsWrapper(
            onRequest: (options, handler) {
              onRequestRun = true;
              expect(
                options.path,
                request.path,
                reason: 'the request path should be ${request.path}',
              );
              handler.next(options);
            },
            onResponse: (response, handler) {
              onResponseRun = true;
              expect(
                response.data.toString(),
                contains('id'),
                reason: 'the response should contain id field',
              );
              expect(
                response.data.toString(),
                contains('name'),
                reason: 'the response should contain name field',
              );
              expect(
                response.data.toString(),
                contains('age'),
                reason: 'the response should contain age field',
              );
              handler.next(response);
            },
            onError: (error, handler) {
              fail('The request should result in success.');
            },
          ),
        ],
      );

      await networkManager.init('http://localhost:${server.port}');

      final response = await networkManager.request(request);

      expect(onRequestRun, isTrue, reason: 'onRequest should run');
      expect(onResponseRun, isTrue, reason: 'onResponse should run');

      response.when(
        success: (response) {
          expect(response.data, isA<ResponseTestUser>());
          expect(response.data.id, '1');
          expect(response.data.name, 'test');
          expect(response.data.age, 20);
        },
        error: (response) {
          fail('error response: ${response.message}');
        },
      );

      await server.close(force: true);
    });

    test('onRequest and onError', () async {
      final server = await TestServer.createHttpServer(events: const []);

      var onRequestRun = false;
      var onErrorRun = false;

      final request = RequestTestNotFound();
      final networkManager = DioNetworkInvoker(
        onLog: _onLog,
        dioInterceptors: [
          InterceptorsWrapper(
            onRequest: (options, handler) {
              onRequestRun = true;
              expect(
                options.path,
                request.path,
                reason: 'the request path should be ${request.path}',
              );
              handler.next(options);
            },
            onResponse: (response, handler) {
              fail('The request should result in error.');
            },
            onError: (error, handler) {
              onErrorRun = true;
              expect(
                error.response?.statusCode,
                HttpStatus.notFound,
                reason: 'the error should be 404',
              );
              handler.next(error);
            },
          ),
        ],
      );

      await networkManager.init('http://localhost:${server.port}');

      final response = await networkManager.request(request);

      expect(onRequestRun, isTrue, reason: 'onRequest should run');
      expect(onErrorRun, isTrue, reason: 'onError should run');

      response.when(
        success: (response) {
          fail('success response: ${response.data}');
        },
        error: (response) {
          expect(response.isFromServer, isTrue, reason: response.message);
          expect(response.isFromLocal, isFalse, reason: response.message);
          expect(
            response.statusCode,
            HttpStatus.notFound,
            reason: response.message,
          );
        },
      );

      await server.close(force: true);
    });
  });
}

void _onLog(NetworkLog log) {
  // ignore: avoid_print test
  print(
    '${DateTime.now().toIso8601String()} '
    '${log.type}: '
    '${log.message}',
  );
}
