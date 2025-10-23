import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

// Export ProductSearchResult for use by consumers
export '../datasources/product_remote_data_source.dart'
    show ProductSearchResult;

class ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;

  ProductRepository({ProductRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? ProductRemoteDataSource();

  // Get all products with pagination
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 10,
    String? sortBy,
  }) async {
    return await _remoteDataSource.getProducts(
      page: page,
      limit: limit,
      sortBy: sortBy,
    );
  }

  // Get product by handler/slug
  Future<Product?> getProductByHandler(String handler) async {
    return await _remoteDataSource.getProductByHandler(handler);
  }

  // Search products with metadata
  Future<ProductSearchResult> searchProducts({
    String? query,
    int page = 1,
    int limit = 10,
  }) async {
    return await _remoteDataSource.searchProducts(
      query: query,
      page: page,
      limit: limit,
    );
  }
}
