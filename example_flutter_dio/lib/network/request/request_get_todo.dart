import 'package:example_flutter_dio/network/app_network_constants.dart';
import 'package:example_flutter_dio/network/response/response_todo.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// The request command for fetching todos.
final class RequestGetTodo extends RequestCommand<ResponseTodo> {
  /// Create an instance of [RequestGetTodo].
  RequestGetTodo({required this.id});

  // ignore: public_member_api_docs model field
  final int id;

  @override
  String get path => AppNetworkConstants.todoById(id);

  @override
  ResponseTodo get sampleModel => const ResponseTodo.empty();
}
