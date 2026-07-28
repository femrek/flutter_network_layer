// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadMetadata _$UploadMetadataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UploadMetadata', json, ($checkedConvert) {
      final val = UploadMetadata(
        targetTable: $checkedConvert('targetTable', (v) => v as String?),
        overwrite: $checkedConvert('overwrite', (v) => v as bool?),
      );
      return val;
    });

Map<String, dynamic> _$UploadMetadataToJson(UploadMetadata instance) =>
    <String, dynamic>{
      'targetTable': instance.targetTable,
      'overwrite': instance.overwrite,
    };
