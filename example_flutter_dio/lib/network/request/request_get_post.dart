import 'package:example_flutter_dio/network/app_network_constants.dart';
import 'package:example_flutter_dio/network/response/response_post.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// The request command for getting a post.
final class RequestGetPost extends RequestCommand<ResponsePost> {
  /// Create an instance of [RequestGetPost].
  RequestGetPost({required this.id});

  /// the id of the post to get
  final int id;

  @override
  String get path => AppNetworkConstants.postById(id);

  @override
  ResponsePost get sampleModel => const ResponsePost.empty();
}
