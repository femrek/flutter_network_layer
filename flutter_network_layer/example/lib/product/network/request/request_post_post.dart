import 'package:example/product/network/response/response_post.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The request command for posting a post.
final class RequestPostPost extends RequestCommand<ResponsePost> {
  /// Create an instance of [RequestPostPost].
  RequestPostPost({
    required this.userId,
    required this.title,
    required this.body,
  });

  // ignore: public_member_api_docs model field
  final int userId;

  // ignore: public_member_api_docs model field
  final String title;

  // ignore: public_member_api_docs model field
  final String body;

  @override
  Map<String, dynamic> get data => {
        'userId': userId,
        'title': title,
        'body': body,
      };

  @override
  HttpRequestMethod get method => HttpRequestMethod.post;

  @override
  String get path => '/posts';

  @override
  ResponsePost get sampleModel => const ResponsePost.empty();
}
