import 'package:flutter_network_layer_dart/flutter_network_layer_dart.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';
import 'package:http_test_server/http_test_server.dart';
import 'package:test/test.dart';

import 'data/request/request_test_1.dart';

void main() {
  group('Basic Test', () {
    <INetworkInvoker>[
      DioNetworkInvoker(),
      DartNetworkInvoker(),
    ].forEach((e) {
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
}
