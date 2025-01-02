import 'package:flutter/material.dart';
import 'package:flutter_network_layer/flutter_network_layer.dart';

/// The response model for the post response.
@immutable
final class ResponsePost implements IResponseModel {
  /// Create an instance of [ResponsePost].
  const ResponsePost({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  /// Create an empty instance of [ResponsePost].
  const ResponsePost.empty() : this();

  // ignore: public_member_api_docs model field
  final int? userId;

  // ignore: public_member_api_docs model field
  final int? id;

  // ignore: public_member_api_docs model field
  final String? title;

  // ignore: public_member_api_docs model field
  final String? body;

  @override
  IResponseModel fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw Exception('Invalid response type: ${json.runtimeType}');
    }

    return ResponsePost(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() => toJson().toString();
}
