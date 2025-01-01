import 'package:flutter_template_network_layer/product/network/response/response_todo.dart';
import 'package:network/network.dart';

/// The response model for the todos response.
final class ResponseTodoList implements IResponseModel {
  /// Create an instance of [ResponseTodoList].
  const ResponseTodoList({
    required this.todos,
  });

  /// Create an empty instance of [ResponseTodoList].
  const ResponseTodoList.empty() : this(todos: const []);

  /// Create an empty instance of [ResponseTodoList].
  final List<ResponseTodo> todos;

  @override
  ResponseTodoList fromJson(dynamic json) {
    if (json is! List<dynamic>) {
      throw Exception('Invalid response type: ${json.runtimeType}');
    }

    return ResponseTodoList(
      todos: json
          .map(
            (e) => ResponseTodo.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  List<Map<String, dynamic>> toJson() {
    return todos.map((e) => e.toJson()).toList();
  }

  @override
  String toString() => toJson().toString();
}
