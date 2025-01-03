import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';
import 'package:test/test.dart';

import 'data/request/request_test_not_found.dart';
import 'data/request/request_test_user.dart';
import 'data/response/response_test_user.dart';
import 'data/test_paths.dart';

void main() async {
  final networkManager = DioNetworkInvoker(
    onLog: _onLog,
  );

  late HttpServer server;
  try {
    server = await HttpServer.bind('localhost', 0)
      ..listen((HttpRequest request) async {
        final body = await request.fold<List<int>>(
            [], (previous, element) => previous..addAll(element));
        final bodyString = String.fromCharCodes(body);

        // ignore: avoid_print test
        print('TEST_SERVER: request: ${request.method} ${request.uri.path}'
            '\n$bodyString');

        if (request.method == 'GET') {
          if (request.uri.path == TestPaths.testUser) {
            request.response
              ..statusCode = HttpStatus.ok
              ..write('{"id": "1", "name": "test", "age": 20}');
          } else {
            request.response
              ..statusCode = HttpStatus.notFound
              ..write('Not Found');
          }
        } else {
          request.response
            ..statusCode = HttpStatus.methodNotAllowed
            ..write('Method Not Allowed');
        }

        await request.response.close();
      });
  } on Exception catch (_) {
    fail('test server failed to start');
  }

  await networkManager.init('http://localhost:${server.port}');

  group('DioNetworkInvoker GET test', () {
    test('request success', () async {
      final response = await networkManager.request(RequestTestUser());

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
    });

    test('request not found', () async {
      final response = await networkManager.request(RequestTestNotFound());

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
    });
  });

  group('DioNetworkInvoker interceptor test', () {
    test('onRequest and onResponse', () async {
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
    });

    test('onRequest and onError', () async {
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
    });
  });
}

void _onLog(LogLevel level, String message) {
  // ignore: avoid_print test
  print(
    '${DateTime.now().toIso8601String()} '
    '${level.name.toUpperCase()}: '
    '$message',
  );
}
