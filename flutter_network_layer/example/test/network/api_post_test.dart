import 'package:example/product/network/request/request_post_post.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final nm = DioNetworkInvoker(
    onLog: (log) {
      // ignore: avoid_print logger
      print('API POST TEST: [${log.type}] ${log.type}');
    },
  );
  await nm.init('https://jsonplaceholder.typicode.com');

  group('POST requests to api', () {
    test('POST a post', () async {
      const userId = 1;
      const title = 'foo';
      const body = 'bar';

      final response = await nm.request(RequestPostPost(
        userId: userId,
        title: title,
        body: body,
      ));
      expect(response, isNotNull);

      response.when(
        success: (response) {
          expect(response.data.id, isNotNull, reason: 'Expected post id');
          expect(response.data.userId, userId, reason: 'Expected post user id');
          expect(response.data.title, title, reason: 'Expected post title');
          expect(response.data.body, body, reason: 'Expected post body');
        },
        error: (response) {
          fail('Failed to post a post');
        },
      );
    });
  });
}
