import 'package:flutter_network_layer_dart/flutter_network_layer_dart.dart';
import 'package:http_test_server/http_test_server.dart';
import 'package:test/test.dart';

import 'data/test_request_commands.dart';

void main() {
  group('Basic test for DartNetworkInvoker', () {
    test('test 1', () async {
      final server = await TestServer.createHttpServer(events: [
        StandardServerEvent(
          matcher: ServerEvent.standardMatcher(paths: ['/test1']),
          handler: (request) {
            return '{"field1": "Hello, world!"}';
          },
        )
      ]);

      final url = 'http://localhost:${server.port}';
      final invoker = DartNetworkInvoker();
      await invoker.init(url);

      final responseResult = await invoker.request(TestRequest1());

      final response = responseResult.when(
        success: (response) {
          expect(response.statusCode, 200);
          return response.data;
        },
        error: (error) {
          throw Exception('Error: ${error.message}');
        },
      );

      expect(response.field1, 'Hello, world!');

      await server.close(force: true);
    });
  });
}
