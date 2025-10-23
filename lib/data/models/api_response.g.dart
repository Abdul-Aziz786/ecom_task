// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => ApiResponse<T>(
  statusCode: (json['statusCode'] as num).toInt(),
  success: json['success'] as bool,
  data: fromJsonT(json['data']),
  path: json['path'] as String,
  message: json['message'] as String,
  meta: json['meta'] == null
      ? null
      : PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ApiResponseToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'success': instance.success,
  'data': toJsonT(instance.data),
  'path': instance.path,
  'message': instance.message,
  'meta': instance.meta,
};

PaginationMeta _$PaginationMetaFromJson(Map<String, dynamic> json) =>
    PaginationMeta(
      total: (json['total'] as num).toInt(),
      items: (json['items'] as num).toInt(),
      currentPage: (json['currentPage'] as num).toInt(),
      perPage: (json['perPage'] as num).toInt(),
      lastPage: (json['lastPage'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationMetaToJson(PaginationMeta instance) =>
    <String, dynamic>{
      'total': instance.total,
      'items': instance.items,
      'currentPage': instance.currentPage,
      'perPage': instance.perPage,
      'lastPage': instance.lastPage,
    };

SearchData<T> _$SearchDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => SearchData<T>(
  products: fromJsonT(json['products']),
  brands: (json['brands'] as List<dynamic>?)
      ?.map((e) => BrandSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
  attributes: (json['attributes'] as List<dynamic>?)
      ?.map((e) => AttributeSummary.fromJson(e as Map<String, dynamic>))
      .toList(),
  ratingsCounts: (json['ratingsCounts'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
);

Map<String, dynamic> _$SearchDataToJson<T>(
  SearchData<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'products': toJsonT(instance.products),
  'brands': instance.brands?.map((e) => e.toJson()).toList(),
  'attributes': instance.attributes?.map((e) => e.toJson()).toList(),
  'ratingsCounts': instance.ratingsCounts,
};

BrandSummary _$BrandSummaryFromJson(Map<String, dynamic> json) => BrandSummary(
  id: json['id'] as String,
  handle: json['handle'] as String,
  name: json['name'] as String,
  productCount: (json['productCount'] as num).toInt(),
);

Map<String, dynamic> _$BrandSummaryToJson(BrandSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'handle': instance.handle,
      'name': instance.name,
      'productCount': instance.productCount,
    };

AttributeSummary _$AttributeSummaryFromJson(Map<String, dynamic> json) =>
    AttributeSummary(
      title: json['title'] as String,
      code: json['code'] as String,
      values: (json['values'] as List<dynamic>)
          .map((e) => AttributeValueSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributeSummaryToJson(AttributeSummary instance) =>
    <String, dynamic>{
      'title': instance.title,
      'code': instance.code,
      'values': instance.values.map((e) => e.toJson()).toList(),
    };

AttributeValueSummary _$AttributeValueSummaryFromJson(
  Map<String, dynamic> json,
) => AttributeValueSummary(
  value: json['value'] as String,
  productCount: (json['productCount'] as num).toInt(),
);

Map<String, dynamic> _$AttributeValueSummaryToJson(
  AttributeValueSummary instance,
) => <String, dynamic>{
  'value': instance.value,
  'productCount': instance.productCount,
};
