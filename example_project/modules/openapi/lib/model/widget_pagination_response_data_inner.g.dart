// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_pagination_response_data_inner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidgetPaginationResponseDataInner _$WidgetPaginationResponseDataInnerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WidgetPaginationResponseDataInner', json, (
  $checkedConvert,
) {
  final val = WidgetPaginationResponseDataInner(
    id: $checkedConvert('id', (v) => v as String?),
    name: $checkedConvert('name', (v) => v as String?),
    widgetType: $checkedConvert('widgetType', (v) => v as String),
    actionUrl: $checkedConvert('actionUrl', (v) => v as String?),
    style: $checkedConvert('style', (v) => v as String?),
    content: $checkedConvert('content', (v) => v as String?),
    fontSize: $checkedConvert('fontSize', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$WidgetPaginationResponseDataInnerToJson(
  WidgetPaginationResponseDataInner instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'widgetType': instance.widgetType,
  'actionUrl': instance.actionUrl,
  'style': instance.style,
  'content': instance.content,
  'fontSize': instance.fontSize,
};
