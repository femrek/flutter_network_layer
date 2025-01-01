import 'package:flutter_template_network_layer/product/network/response/response_todo.dart';
import 'package:network/network.dart';

/// The request command for fetching todos.
final class RequestGetTodo implements IRequestCommand<ResponseTodo> {
  /// Create an instance of [RequestGetTodo].
  const RequestGetTodo({
    required this.id,
  });

  /// The id of the t0do to fetch.
  final int id;

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
  String get path => '/todos/$id';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseTodo get sampleModel => const ResponseTodo.empty();
}
