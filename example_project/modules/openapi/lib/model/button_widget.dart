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

part 'button_widget.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ButtonWidget extends Schema {
  /// Returns a new [ButtonWidget] instance.
  ButtonWidget({
    this.id,
    this.name,
    required this.widgetType,
    this.actionUrl,
    this.style,
  });

  @JsonKey(name: r'id')
  final String? id;

  @JsonKey(name: r'name')
  final String? name;

  @JsonKey(name: r'widgetType')
  final String widgetType;

  @JsonKey(name: r'actionUrl')
  final String? actionUrl;

  @JsonKey(name: r'style')
  final String? style;

  /// The factory instance for creating [ButtonWidget] from JSON.
  static const factory = ButtonWidgetFactory();

  factory ButtonWidget.fromJson(Map<String, dynamic> json) => _$ButtonWidgetFromJson(json);

  Map<String, dynamic> toJson() => _$ButtonWidgetToJson(this);

  static List<ButtonWidget> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ButtonWidget>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ButtonWidget.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ButtonWidget> mapFromJson(dynamic json) {
    final map = <String, ButtonWidget>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ButtonWidget.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class ButtonWidgetFactory extends JsonSchemaFactory<ButtonWidget> {
  const ButtonWidgetFactory();

  @override
  ButtonWidget fromJson(dynamic json) => ButtonWidget.fromJson(json as Map<String, dynamic>);
}
