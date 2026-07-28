// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonWidget _$ButtonWidgetFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ButtonWidget', json, ($checkedConvert) {
      final val = ButtonWidget(
        id: $checkedConvert('id', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        widgetType: $checkedConvert('widgetType', (v) => v as String),
        actionUrl: $checkedConvert('actionUrl', (v) => v as String?),
        style: $checkedConvert('style', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ButtonWidgetToJson(ButtonWidget instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'widgetType': instance.widgetType,
      'actionUrl': instance.actionUrl,
      'style': instance.style,
    };
