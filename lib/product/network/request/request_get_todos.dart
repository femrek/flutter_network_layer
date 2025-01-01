import 'package:flutter_template_network_layer/product/network/response/response_todo_list.dart';
import 'package:network/network.dart';

/// The request command for fetching all todos.
class RequestGetTodos implements IRequestCommand<ResponseTodoList> {
  /// Create an instance of [RequestGetTodos].
  const RequestGetTodos();

  @override
  Map<String, dynamic> get data => const {};

  @override
  Map<String, dynamic> get headers => const {};

  @override
  HttpRequestMethod get method => HttpRequestMethod.get;

  @override
  OnProgressCallback? get onReceiveProgressUpdate => null;

  @override
  OnProgressCallback? get onSendProgressUpdate => null;

  @override
  String get path => '/todos';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseTodoList get sampleModel => const ResponseTodoList.empty();
}
