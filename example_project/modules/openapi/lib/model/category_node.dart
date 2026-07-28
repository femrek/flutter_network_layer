//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_node.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CategoryNode extends Schema {
  /// Returns a new [CategoryNode] instance.
  CategoryNode({
    this.categoryName,
    this.subCategories = const [],
  });

  @JsonKey(name: r'categoryName')
  final String? categoryName;

  /// Child categories
  @JsonKey(name: r'subCategories')
  final List<CategoryNode> subCategories;

  /// The factory instance for creating [CategoryNode] from JSON.
  static const factory = CategoryNodeFactory();

  factory CategoryNode.fromJson(Map<String, dynamic> json) => _$CategoryNodeFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryNodeToJson(this);

  static List<CategoryNode> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CategoryNode>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CategoryNode.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CategoryNode> mapFromJson(dynamic json) {
    final map = <String, CategoryNode>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CategoryNode.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class CategoryNodeFactory extends JsonSchemaFactory<CategoryNode> {
  const CategoryNodeFactory();

  @override
  CategoryNode fromJson(dynamic json) => CategoryNode.fromJson(json as Map<String, dynamic>);
}
