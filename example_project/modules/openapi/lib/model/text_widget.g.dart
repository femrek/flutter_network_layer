// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextWidget _$TextWidgetFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TextWidget', json, ($checkedConvert) {
      final val = TextWidget(
        id: $checkedConvert('id', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        widgetType: $checkedConvert('widgetType', (v) => v as String),
        content: $checkedConvert('content', (v) => v as String?),
        fontSize: $checkedConvert('fontSize', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$TextWidgetToJson(TextWidget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'widgetType': instance.widgetType,
      'content': instance.content,
      'fontSize': instance.fontSize,
    };
