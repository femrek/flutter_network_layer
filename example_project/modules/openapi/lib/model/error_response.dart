//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ErrorResponse extends Schema {
  /// Returns a new [ErrorResponse] instance.
  ErrorResponse({
    this.errorCode,
    this.errorMessage,
  });

  /// Application specific error code
  @JsonKey(name: r'errorCode')
  final String? errorCode;

  /// Error description
  @JsonKey(name: r'errorMessage')
  final String? errorMessage;

  /// The factory instance for creating [ErrorResponse] from JSON.
  static const factory = ErrorResponseFactory();

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  static List<ErrorResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ErrorResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ErrorResponse.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ErrorResponse> mapFromJson(dynamic json) {
    final map = <String, ErrorResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ErrorResponse.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class ErrorResponseFactory extends JsonSchemaFactory<ErrorResponse> {
  const ErrorResponseFactory();

  @override
  ErrorResponse fromJson(dynamic json) => ErrorResponse.fromJson(json as Map<String, dynamic>);
}
