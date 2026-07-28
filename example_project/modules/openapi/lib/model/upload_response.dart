//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_response.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UploadResponse extends Schema {
  /// Returns a new [UploadResponse] instance.
  UploadResponse({
    this.jobId,
    this.message,
  });

  /// The background job ID tracking the upload
  @JsonKey(name: r'jobId')
  final String? jobId;

  /// Human readable message
  @JsonKey(name: r'message')
  final String? message;

  /// The factory instance for creating [UploadResponse] from JSON.
  static const factory = UploadResponseFactory();

  factory UploadResponse.fromJson(Map<String, dynamic> json) => _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);

  static List<UploadResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadResponse.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadResponse> mapFromJson(dynamic json) {
    final map = <String, UploadResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadResponse.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class UploadResponseFactory extends JsonSchemaFactory<UploadResponse> {
  const UploadResponseFactory();

  @override
  UploadResponse fromJson(dynamic json) => UploadResponse.fromJson(json as Map<String, dynamic>);
}
