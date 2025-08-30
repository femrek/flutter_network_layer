import 'package:flutter/material.dart';
import 'package:flutter_network_layer_dio/flutter_network_layer_dio.dart';

/// The response model for todos.
@immutable
final class ResponseTodo extends JsonResponseModel {
  /// Create an instance of [ResponseTodo].
  const ResponseTodo({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  /// Create an empty instance of [ResponseTodo].
  const ResponseTodo.empty() : this();

  /// Create an instance of [ResponseTodo] from a JSON object.
  factory ResponseTodo.fromJson(Map<String, dynamic> json) {
    return ResponseTodo(
      userId: json['userId'] as int?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      completed: json['completed'] as bool?,
    );
  }

  // ignore: public_member_api_docs model field
  final int? userId;

  // ignore: public_member_api_docs model field
  final int? id;

  // ignore: public_member_api_docs model field
  final String? title;

  // ignore: public_member_api_docs model field
  final bool? completed;

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'completed': completed,
    };
  }

  @override
  ResponseTodo fromJson(dynamic json) {
    return ResponseTodo.fromJson(json as Map<String, dynamic>);
  }

  @override
  String toString() => toJson().toString();
}
