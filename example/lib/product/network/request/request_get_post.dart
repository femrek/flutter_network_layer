import 'package:example/product/network/response/response_post.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The request command for getting a post.
final class RequestGetPost implements IRequestCommand<ResponsePost> {
  /// Create an instance of [RequestGetPost].
  const RequestGetPost({
    required this.id,
  });

  /// the id of the post to get
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
  String get path => '/posts/$id';

  @override
  RequestPayloadType get payloadType => RequestPayloadType.json;

  @override
  ResponsePost get sampleModel => const ResponsePost.empty();
}
