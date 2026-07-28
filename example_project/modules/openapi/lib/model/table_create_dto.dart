//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_create_dto.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableCreateDTO extends Schema {
  /// Returns a new [TableCreateDTO] instance.
  TableCreateDTO({
    this.name,
    this.capacity,
  });

  @JsonKey(name: r'name')
  final String? name;

  @JsonKey(name: r'capacity')
  final int? capacity;

  /// The factory instance for creating [TableCreateDTO] from JSON.
  static const factory = TableCreateDTOFactory();

  factory TableCreateDTO.fromJson(Map<String, dynamic> json) => _$TableCreateDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TableCreateDTOToJson(this);

  static List<TableCreateDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TableCreateDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TableCreateDTO.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TableCreateDTO> mapFromJson(dynamic json) {
    final map = <String, TableCreateDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TableCreateDTO.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class TableCreateDTOFactory extends JsonSchemaFactory<TableCreateDTO> {
  const TableCreateDTOFactory();

  @override
  TableCreateDTO fromJson(dynamic json) => TableCreateDTO.fromJson(json as Map<String, dynamic>);
}
