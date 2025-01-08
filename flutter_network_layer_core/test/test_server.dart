import 'dart:io';

typedef OnRequestCallback = void Function(HttpRequest request);

abstract final class TestServer {
  static Future<HttpServer> bindServer({
    required OnRequestCallback onRequest,
  }) async {
    final server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      0,
    );

    server.listen((HttpRequest request) {
      onRequest(request);
      request.response.close();
    });
    return server;
  }
// }) async {
//     final server = await HttpServer.bind(
//       InternetAddress.loopbackIPv4,
//       8080,
//     );
//
//     server.listen((HttpRequest request) {
//       if (request.method == 'GET') {
//         switch (request.uri.path) {
//           case '/basic_test':
//             request.response
//               ..statusCode = HttpStatus.ok
//               ..write('{"field1": "value1"}');
//           case '/basic_test/1':
//             request.response
//               ..statusCode = HttpStatus.ok
//               ..write('{"field1": "value1"}');
//           default:
//             request.response
//               ..statusCode = HttpStatus.notFound
//               ..write('Not Found');
//         }
//       } else {
//         request.response
//           ..statusCode = HttpStatus.methodNotAllowed
//           ..write('Unsupported request: ${request.method}.');
//       }
//
//       request.response.close();
//     });
//     return server;
//   }
}
