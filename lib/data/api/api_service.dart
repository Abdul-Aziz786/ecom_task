import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/product_model.dart';
import '../models/api_response.dart';
import '../models/search_suggestion_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.stryce.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  /// Get all products with pagination
  @GET('/store/product')
  Future<HttpResponse<ApiResponse<List<Product>>>> getProducts({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('sort') String? sortBy,
    @Query('inStock') bool? inStock = false,
  });

  /// Get product by handler/slug
  @GET('/store/product/{handler}')
  Future<HttpResponse<ApiResponse<Product>>> getProductByHandler(
    @Path('handler') String handler,
  );

  /// Search products
  @GET('/store/product-search')
  Future<HttpResponse<ApiResponse<SearchData<List<Product>>>>> searchProducts({
    @Query('q') String? query,
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('inStock') bool? inStock = false,
  });

  /// Get search suggestions
  @GET('/store/product-search/suggestions')
  Future<SearchSuggestionResponse> getSearchSuggestions(
    @Query('q') String query,
  );
}
