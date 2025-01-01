import 'package:flutter_template_network_layer/product/network/request/request_get_post.dart';
import 'package:flutter_template_network_layer/product/network/request/request_get_todo.dart';
import 'package:flutter_template_network_layer/product/network/request/request_get_todos.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

void main() async {
  final nm = DioNetworkManager(
    onDioLog: (level, message) {
      // ignore: avoid_print logger
      print('API GET TEST: [${level.name}] $message');
    },
  );
  await nm.init('https://jsonplaceholder.typicode.com');

  group('GET requests to todo api', () {
    test('GET a todo', () async {
      const todoId = 1;
      final response = await nm.request(const RequestGetTodo(id: todoId));
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
      final response = await nm.request(const RequestGetTodos());

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
      final response = await nm.request(const RequestGetPost(id: postId));
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
      final response = await nm.request(const RequestGetTodo(id: todoId));
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
