import 'package:example_flutter_dio/network/app_network_constants.dart';
import 'package:example_flutter_dio/network/response/response_todo_list.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// The request command for fetching all todos.
final class RequestGetTodos extends RequestCommand<ResponseTodoList> {
  @override
  String get path => AppNetworkConstants.todos;

  @override
  ResponseTodoList get sampleModel => const ResponseTodoList.empty();
}
