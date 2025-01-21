import 'package:example/product/network/request/request_get_post.dart';
import 'package:example/product/network/request/request_get_todo.dart';
import 'package:example/product/network/request/request_get_todos.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  final nm = DioNetworkInvoker(
    onLog: (log) {
      // ignore: avoid_print logger
      print('API GET TEST: [${log.type}] ${log.message}');
    },
  );
  await nm.init('https://jsonplaceholder.typicode.com');

  group('GET requests to todo api', () {
    test('GET a todo', () async {
      const todoId = 1;
      final response = await nm.request(RequestGetTodo(id: todoId));
      expect(response, isNotNull);

      response.when(
        success: (response) {
          expect(response.data.id, todoId, reason: 'Expected todo: $todoId');
        },
        error: (response) {
          fail('Failed to get todo: $todoId');
        },
      );
    });

    test('GET all todos', () async {
      final response = await nm.request(RequestGetTodos());

      response.when(
        success: (response) {
          expect(
            response.data.todos.isNotEmpty,
            isTrue,
            reason: 'Expected todos',
          );
        },
        error: (response) {
          fail('Failed to get todos');
        },
      );
    });
  });

  group('GET request to post api', () {
    test('GET a post', () async {
      const postId = 1;
      final response = await nm.request(RequestGetPost(id: postId));
      expect(response, isNotNull);

      response.when(
        success: (response) {
          expect(response.data.id, postId, reason: 'Expected post: $postId');
        },
        error: (response) {
          fail('Failed to get post: $postId');
        },
      );
    });
  });

  group('Not found error', () {
    test('GET a todo that does not exist', () async {
      const todoId = 99999;
      final response = await nm.request(RequestGetTodo(id: todoId));
      expect(response, isNotNull, reason: 'Expected a response');

      response.when(
        success: (response) {
          fail('Got a todo that does not exist: $todoId');
        },
        error: (response) {
          expect(response.message, isNotNull, reason: 'Expected error message');
          expect(response.statusCode, 404, reason: 'Expected 404 status code');
        },
      );
    });
  });
}
