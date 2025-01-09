import 'dart:io';

import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';
import 'package:http_test_server/http_test_server.dart';
import 'package:test/test.dart';

import 'data/request/request_test_not_found.dart';
import 'data/request/request_test_user.dart';
import 'data/response/response_test_user.dart';
import 'data/test_paths.dart';

void main() {
  group('DioNetworkInvoker GET test', () {
    test('request success', () async {
      final server = await TestServer.createHttpServer(events: [
        StandardServerEvent(
          matcher: ServerEvent.standardMatcher(paths: [TestPaths.testUser]),
          handler: (request) => '{"id": "1", "name": "test", "age": 20}',
        ),
      ]);

      final networkManager = DioNetworkInvoker(
        onLog: _onLog,
      );
      await networkManager.init('http://localhost:${server.port}');

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

      await server.close(force: true);
    });

    test('request not found', () async {
      final server = await TestServer.createHttpServer(events: const []);

      final networkManager = DioNetworkInvoker(
        onLog: _onLog,
      );
      await networkManager.init('http://localhost:${server.port}');

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

      await server.close(force: true);
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
