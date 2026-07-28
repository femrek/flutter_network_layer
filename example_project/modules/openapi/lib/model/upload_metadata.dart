//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_metadata.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UploadMetadata extends Schema {
  /// Returns a new [UploadMetadata] instance.
  UploadMetadata({
    this.targetTable,
    this.overwrite,
  });

  /// The target table for the upload
  @JsonKey(name: r'targetTable')
  final String? targetTable;

  /// Should existing records be overwritten?
  @JsonKey(name: r'overwrite')
  final bool? overwrite;

  /// The factory instance for creating [UploadMetadata] from JSON.
  static const factory = UploadMetadataFactory();

  factory UploadMetadata.fromJson(Map<String, dynamic> json) => _$UploadMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$UploadMetadataToJson(this);

  static List<UploadMetadata> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UploadMetadata>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UploadMetadata.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UploadMetadata> mapFromJson(dynamic json) {
    final map = <String, UploadMetadata>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UploadMetadata.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class UploadMetadataFactory extends JsonSchemaFactory<UploadMetadata> {
  const UploadMetadataFactory();

  @override
  UploadMetadata fromJson(dynamic json) => UploadMetadata.fromJson(json as Map<String, dynamic>);
}
