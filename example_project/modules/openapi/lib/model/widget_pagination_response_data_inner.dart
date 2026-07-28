//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'button_widget.dart';
import 'text_widget.dart';

part 'widget_pagination_response_data_inner.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WidgetPaginationResponseDataInner extends Schema {
  /// Returns a new [WidgetPaginationResponseDataInner] instance.
  WidgetPaginationResponseDataInner({
    this.id,
    this.name,
    required this.widgetType,
    this.actionUrl,
    this.style,
    this.content,
    this.fontSize,
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

  @JsonKey(name: r'content')
  final String? content;

  @JsonKey(name: r'fontSize')
  final int? fontSize;

  /// The factory instance for creating [WidgetPaginationResponseDataInner] from JSON.
  static const factory = WidgetPaginationResponseDataInnerFactory();

  factory WidgetPaginationResponseDataInner.fromJson(Map<String, dynamic> json) => _$WidgetPaginationResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetPaginationResponseDataInnerToJson(this);

  static List<WidgetPaginationResponseDataInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WidgetPaginationResponseDataInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WidgetPaginationResponseDataInner.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WidgetPaginationResponseDataInner> mapFromJson(dynamic json) {
    final map = <String, WidgetPaginationResponseDataInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WidgetPaginationResponseDataInner.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class WidgetPaginationResponseDataInnerFactory extends JsonSchemaFactory<WidgetPaginationResponseDataInner> {
  const WidgetPaginationResponseDataInnerFactory();

  @override
  WidgetPaginationResponseDataInner fromJson(dynamic json) => WidgetPaginationResponseDataInner.fromJson(json as Map<String, dynamic>);
}
