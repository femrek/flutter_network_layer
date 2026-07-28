// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryNode _$CategoryNodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CategoryNode', json, ($checkedConvert) {
      final val = CategoryNode(
        categoryName: $checkedConvert('categoryName', (v) => v as String?),
        subCategories: $checkedConvert(
          'subCategories',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => CategoryNode.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const [],
        ),
      );
      return val;
    });

Map<String, dynamic> _$CategoryNodeToJson(CategoryNode instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'subCategories': instance.subCategories.map((e) => e.toJson()).toList(),
    };
