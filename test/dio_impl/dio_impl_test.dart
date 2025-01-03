import 'dart:io';

import 'package:flutter_network_layer/flutter_network_layer.dart';
import 'package:flutter_test/flutter_test.dart';

import 'data/request/request_test_not_found.dart';
import 'data/request/request_test_user.dart';
import 'data/response/response_test_user.dart';
import 'data/test_paths.dart';

void main() async {
  final networkManager = DioNetworkInvoker(
    onDioLog: (level, message) {
      // ignore: avoid_print test
      print(
        '${DateTime.now().toIso8601String()} '
        '${level.name.toUpperCase()}: '
        '$message',
      );
    },
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

  group('DioNetworkManager GET test', () {
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
}
