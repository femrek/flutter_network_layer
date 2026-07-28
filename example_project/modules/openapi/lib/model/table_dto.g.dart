// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableDTO _$TableDTOFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TableDTO', json, ($checkedConvert) {
      final val = TableDTO(
        id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
        name: $checkedConvert('name', (v) => v as String?),
        capacity: $checkedConvert('capacity', (v) => (v as num?)?.toInt()),
        status: $checkedConvert('status', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$TableDTOToJson(TableDTO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'capacity': instance.capacity,
  'status': instance.status,
};
