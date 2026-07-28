//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'widget.dart';

part 'text_widget.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TextWidget extends Schema {
  /// Returns a new [TextWidget] instance.
  TextWidget({
    this.id,
    this.name,
    required this.widgetType,
    this.content,
    this.fontSize,
  });

  @JsonKey(name: r'id')
  final String? id;

  @JsonKey(name: r'name')
  final String? name;

  @JsonKey(name: r'widgetType')
  final String widgetType;

  @JsonKey(name: r'content')
  final String? content;

  @JsonKey(name: r'fontSize')
  final int? fontSize;

  /// The factory instance for creating [TextWidget] from JSON.
  static const factory = TextWidgetFactory();

  factory TextWidget.fromJson(Map<String, dynamic> json) => _$TextWidgetFromJson(json);

  Map<String, dynamic> toJson() => _$TextWidgetToJson(this);

  static List<TextWidget> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TextWidget>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TextWidget.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TextWidget> mapFromJson(dynamic json) {
    final map = <String, TextWidget>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TextWidget.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class TextWidgetFactory extends JsonSchemaFactory<TextWidget> {
  const TextWidgetFactory();

  @override
  TextWidget fromJson(dynamic json) => TextWidget.fromJson(json as Map<String, dynamic>);
}
