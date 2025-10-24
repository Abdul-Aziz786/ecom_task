// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSuggestionResponse _$SearchSuggestionResponseFromJson(
  Map<String, dynamic> json,
) => SearchSuggestionResponse(
  statusCode: (json['statusCode'] as num?)?.toInt(),
  success: json['success'] as bool?,
  data: json['data'] == null
      ? null
      : SearchSuggestionData.fromJson(json['data'] as Map<String, dynamic>),
  path: json['path'] as String?,
  message: json['message'] as String?,
  meta: json['meta'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$SearchSuggestionResponseToJson(
  SearchSuggestionResponse instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'success': instance.success,
  'data': instance.data,
  'path': instance.path,
  'message': instance.message,
  'meta': instance.meta,
};

SearchSuggestionData _$SearchSuggestionDataFromJson(
  Map<String, dynamic> json,
) => SearchSuggestionData(
  suggestions: (json['suggestions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SearchSuggestionDataToJson(
  SearchSuggestionData instance,
) => <String, dynamic>{
  'suggestions': instance.suggestions,
  'products': instance.products,
};
