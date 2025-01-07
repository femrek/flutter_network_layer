import 'package:example_flutter_dio/network/response/response_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// The response model for the todos response.
@immutable
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
