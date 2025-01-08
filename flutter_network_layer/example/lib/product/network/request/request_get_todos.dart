import 'package:example/product/network/response/response_todo_list.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The request command for fetching all todos.
final class RequestGetTodos extends RequestCommand<ResponseTodoList> {
  @override
  String get path => '/todos';

  @override
  ResponseTodoList get sampleModel => const ResponseTodoList.empty();
}
