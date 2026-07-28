// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_pagination_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidgetPaginationResponse _$WidgetPaginationResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('WidgetPaginationResponse', json, ($checkedConvert) {
  final val = WidgetPaginationResponse(
    data: $checkedConvert(
      'data',
      (v) =>
          (v as List<dynamic>?)
              ?.map(
                (e) => WidgetPaginationResponseDataInner.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    ),
    totalElements: $checkedConvert(
      'totalElements',
      (v) => (v as num?)?.toInt(),
    ),
    currentPage: $checkedConvert('currentPage', (v) => (v as num?)?.toInt()),
    pageSize: $checkedConvert('pageSize', (v) => (v as num?)?.toInt()),
  );
  return val;
});

Map<String, dynamic> _$WidgetPaginationResponseToJson(
  WidgetPaginationResponse instance,
) => <String, dynamic>{
  'data': instance.data.map((e) => e.toJson()).toList(),
  'totalElements': instance.totalElements,
  'currentPage': instance.currentPage,
  'pageSize': instance.pageSize,
};
