import 'package:example/product/network/response/response_todo.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The request command for fetching todos.
final class RequestGetTodo extends RequestCommand<ResponseTodo> {
  /// Create an instance of [RequestGetTodo].
  RequestGetTodo({
    required this.id,
  });

  /// The id of the t0do to fetch.
  final int id;

  @override
  String get path => '/todos/$id';

  @override
  ResponseTodo get sampleModel => const ResponseTodo.empty();
}
