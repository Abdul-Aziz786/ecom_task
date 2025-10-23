import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final int statusCode;
  final bool success;
  final T data;
  final String path;
  final String message;
  final PaginationMeta? meta;

  ApiResponse({
    required this.statusCode,
    required this.success,
    required this.data,
    required this.path,
    required this.message,
    this.meta,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

@JsonSerializable()
class PaginationMeta {
  final int total;
  final int items;
  final int currentPage;
  final int perPage;
  final int lastPage;

  PaginationMeta({
    required this.total,
    required this.items,
    required this.currentPage,
    required this.perPage,
    required this.lastPage,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationMetaToJson(this);
}

// Search-specific response wrapper
@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class SearchData<T> {
  final T products;
  final List<BrandSummary>? brands;
  final List<AttributeSummary>? attributes;
  final Map<String, int>? ratingsCounts;

  SearchData({
    required this.products,
    this.brands,
    this.attributes,
    this.ratingsCounts,
  });

  factory SearchData.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$SearchDataFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$SearchDataToJson(this, toJsonT);
}

@JsonSerializable()
class BrandSummary {
  final String id;
  final String handle;
  final String name;
  final int productCount;

  BrandSummary({
    required this.id,
    required this.handle,
    required this.name,
    required this.productCount,
  });

  factory BrandSummary.fromJson(Map<String, dynamic> json) =>
      _$BrandSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$BrandSummaryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AttributeSummary {
  final String title;
  final String code;
  final List<AttributeValueSummary> values;

  AttributeSummary({
    required this.title,
    required this.code,
    required this.values,
  });

  factory AttributeSummary.fromJson(Map<String, dynamic> json) =>
      _$AttributeSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeSummaryToJson(this);
}

@JsonSerializable()
class AttributeValueSummary {
  final String value;
  final int productCount;

  AttributeValueSummary({required this.value, required this.productCount});

  factory AttributeValueSummary.fromJson(Map<String, dynamic> json) =>
      _$AttributeValueSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeValueSummaryToJson(this);
}
