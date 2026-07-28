// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Widget _$WidgetFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Widget', json, ($checkedConvert) {
      final val = Widget(
        id: $checkedConvert('id', (v) => v as String?),
        name: $checkedConvert('name', (v) => v as String?),
        widgetType: $checkedConvert('widgetType', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$WidgetToJson(Widget instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'widgetType': instance.widgetType,
};
