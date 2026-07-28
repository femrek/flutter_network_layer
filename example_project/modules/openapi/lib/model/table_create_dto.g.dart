// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableCreateDTO _$TableCreateDTOFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TableCreateDTO', json, ($checkedConvert) {
      final val = TableCreateDTO(
        name: $checkedConvert('name', (v) => v as String?),
        capacity: $checkedConvert('capacity', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$TableCreateDTOToJson(TableCreateDTO instance) =>
    <String, dynamic>{'name': instance.name, 'capacity': instance.capacity};
