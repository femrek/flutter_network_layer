//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:dart_network_layer_core/dart_network_layer_core.dart';
import 'package:json_annotation/json_annotation.dart';
import 'widget_pagination_response_data_inner.dart';

part 'widget_pagination_response.g.dart';
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class WidgetPaginationResponse extends Schema {
  /// Returns a new [WidgetPaginationResponse] instance.
  WidgetPaginationResponse({
    this.data = const [],
    this.totalElements,
    this.currentPage,
    this.pageSize,
  });

  @JsonKey(name: r'data')
  final List<WidgetPaginationResponseDataInner> data;

  @JsonKey(name: r'totalElements')
  final int? totalElements;

  @JsonKey(name: r'currentPage')
  final int? currentPage;

  @JsonKey(name: r'pageSize')
  final int? pageSize;

  /// The factory instance for creating [WidgetPaginationResponse] from JSON.
  static const factory = WidgetPaginationResponseFactory();

  factory WidgetPaginationResponse.fromJson(Map<String, dynamic> json) => _$WidgetPaginationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WidgetPaginationResponseToJson(this);

  static List<WidgetPaginationResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WidgetPaginationResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WidgetPaginationResponse.fromJson(row as Map<String, dynamic>);
        result.add(value);
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WidgetPaginationResponse> mapFromJson(dynamic json) {
    final map = <String, WidgetPaginationResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WidgetPaginationResponse.fromJson(entry.value as Map<String, dynamic>);
        map[entry.key] = value;
      }
    }
    return map;
  }
}

class WidgetPaginationResponseFactory extends JsonSchemaFactory<WidgetPaginationResponse> {
  const WidgetPaginationResponseFactory();

  @override
  WidgetPaginationResponse fromJson(dynamic json) => WidgetPaginationResponse.fromJson(json as Map<String, dynamic>);
}
