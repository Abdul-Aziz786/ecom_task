import 'package:json_annotation/json_annotation.dart';
import 'product_model.dart';

part 'search_suggestion_model.g.dart';

@JsonSerializable()
class SearchSuggestionResponse {
  final int? statusCode;
  final bool? success;
  final SearchSuggestionData? data;
  final String? path;
  final String? message;
  final Map<String, dynamic>? meta;

  SearchSuggestionResponse({
    this.statusCode,
    this.success,
    this.data,
    this.path,
    this.message,
    this.meta,
  });

  factory SearchSuggestionResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSuggestionResponseToJson(this);
}

@JsonSerializable()
class SearchSuggestionData {
  final List<String>? suggestions;
  final List<Product>? products;

  SearchSuggestionData({this.suggestions, this.products});

  factory SearchSuggestionData.fromJson(Map<String, dynamic> json) =>
      _$SearchSuggestionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSuggestionDataToJson(this);
}
