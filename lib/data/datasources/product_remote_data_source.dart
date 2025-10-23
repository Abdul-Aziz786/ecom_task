import '../api/api_service.dart';
import '../api/api_client.dart';
import '../models/product_model.dart';
import '../models/api_response.dart';

/// Search result with metadata for filters
class ProductSearchResult {
  final List<Product> products;
  final List<BrandSummary>? brands;
  final List<AttributeSummary>? attributes;
  final Map<String, int>? ratingsCounts;

  ProductSearchResult({
    required this.products,
    this.brands,
    this.attributes,
    this.ratingsCounts,
  });
}

/// Remote data source for product API calls
class ProductRemoteDataSource {
  late final ApiService _apiService;

  ProductRemoteDataSource() {
    _apiService = ApiService(ApiClient().dio);
  }

  /// Get products from API
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 10,
    String? sortBy,
  }) async {
    try {
      final response = await _apiService.getProducts(
        page: page,
        limit: limit,
        sortBy: sortBy,
      );
      return response.data.data; // Unwrap the data from ApiResponse
    } catch (e, st) {
      print(st);
      throw Exception('Failed to fetch products: $e');
    }
  }

  /// Get product by handler from API
  Future<Product> getProductByHandler(String handler) async {
    try {
      final response = await _apiService.getProductByHandler(handler);
      return response.data.data; // Unwrap the data from ApiResponse
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  /// Search products from API with metadata
  Future<ProductSearchResult> searchProducts({
    String? query,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiService.searchProducts(
        query: query,
        page: page,
        limit: limit,
      );
      final searchData = response.data.data; // Unwrap the data from ApiResponse
      return ProductSearchResult(
        products: searchData.products,
        brands: searchData.brands,
        attributes: searchData.attributes,
        ratingsCounts: searchData.ratingsCounts,
      );
    } catch (e, st) {
      print(st);
      throw Exception('Failed to search products: $e');
    }
  }
}
