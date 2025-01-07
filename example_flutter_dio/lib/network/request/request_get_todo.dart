import 'package:example_flutter_dio/network/app_network_constants.dart';
import 'package:example_flutter_dio/network/response/response_todo.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// The request command for fetching todos.
final class RequestGetTodo implements IRequestCommand<ResponseTodo> {
  /// Create an instance of [RequestGetTodo].
  const RequestGetTodo({
    required this.id,
  });

  // ignore: public_member_api_docs model field
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
  String get path => AppNetworkConstants.todoById(id);

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponseTodo get sampleModel => const ResponseTodo.empty();
}
