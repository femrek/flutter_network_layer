import 'package:example/product/network/response/response_post.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The request command for getting a post.
final class RequestGetPost extends RequestCommand<ResponsePost> {
  /// Create an instance of [RequestGetPost].
  RequestGetPost({
    required this.id,
  });

  /// the id of the post to get
  final int id;

  @override
  String get path => '/posts/$id';

  @override
  ResponsePost get sampleModel => const ResponsePost.empty();
}
