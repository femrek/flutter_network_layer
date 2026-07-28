//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'table_dto.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableDTO extends Schema {
  /// Returns a new [TableDTO] instance.
  TableDTO({
    this.id,
    this.name,
    this.capacity,
    this.status,
  });

  @JsonKey(name: r'id')
  final int? id;

  @JsonKey(name: r'name')
  final String? name;

  @JsonKey(name: r'capacity')
  final int? capacity;

  @JsonKey(name: r'status')
  final String? status;

  /// The factory instance for creating [TableDTO] from JSON.
  static const factory = TableDTOFactory();

  factory TableDTO.fromJson(Map<String, dynamic> json) => _$TableDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TableDTOToJson(this);

  static List<TableDTO> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TableDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TableDTO.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TableDTO> mapFromJson(dynamic json) {
    final map = <String, TableDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TableDTO.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class TableDTOFactory extends JsonSchemaFactory<TableDTO> {
  const TableDTOFactory();

  @override
  TableDTO fromJson(dynamic json) => TableDTO.fromJson(json as Map<String, dynamic>);
}
