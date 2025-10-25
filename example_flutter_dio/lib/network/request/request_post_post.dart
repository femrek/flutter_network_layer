import 'package:example_flutter_dio/network/app_network_constants.dart';
import 'package:example_flutter_dio/network/response/response_post.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

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
  Map<String, dynamic> get payload => {
        'userId': userId,
        'title': title,
        'body': body,
      };

  @override
  HttpRequestMethod get method => HttpRequestMethod.post;

  @override
  String get path => AppNetworkConstants.posts;

  @override
  ResponsePost get sampleModel => const ResponsePost.empty();
}
