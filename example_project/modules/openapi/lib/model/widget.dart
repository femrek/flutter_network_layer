//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'widget.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Widget extends Schema {
  /// Returns a new [Widget] instance.
  Widget({
    this.id,
    this.name,
    required this.widgetType,
  });

  @JsonKey(name: r'id')
  final String? id;

  @JsonKey(name: r'name')
  final String? name;

  @JsonKey(name: r'widgetType')
  final String widgetType;

  /// The factory instance for creating [Widget] from JSON.
  static const factory = WidgetFactory();

  factory Widget.fromJson(Map<String, dynamic> json) => _$WidgetFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetToJson(this);

  static List<Widget> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Widget>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Widget.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Widget> mapFromJson(dynamic json) {
    final map = <String, Widget>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Widget.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class WidgetFactory extends JsonSchemaFactory<Widget> {
  const WidgetFactory();

  @override
  Widget fromJson(dynamic json) => Widget.fromJson(json as Map<String, dynamic>);
}
