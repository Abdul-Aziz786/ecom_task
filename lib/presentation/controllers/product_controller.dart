import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/models/api_response.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  // Pagination controller
  final PagingController<int, Product> pagingController = PagingController(
    firstPageKey: 1,
  );

  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);

  // Search metadata
  final RxList<BrandSummary> brands = <BrandSummary>[].obs;
  final RxList<AttributeSummary> attributes = <AttributeSummary>[].obs;
  final Rx<Map<String, int>?> ratingsCounts = Rx<Map<String, int>?>(null);

  // Search query
  final RxString searchQuery = ''.obs;

  static const _pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_fetchPage);

    // Setup debounced search using GetX's Worker
    debounce(
      searchQuery,
      (_) => _refreshPagination(),
      time: const Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  // Fetch page data
  Future<void> _fetchPage(int pageKey) async {
    try {
      hasError.value = false;

      final result = await _productRepository.searchProducts(
        page: pageKey,
        limit: _pageSize,
        query: searchQuery.value.isEmpty ? null : searchQuery.value,
      );

      // Update search metadata
      if (result.brands != null) brands.value = result.brands!;
      if (result.attributes != null) attributes.value = result.attributes!;
      if (result.ratingsCounts != null) {
        ratingsCounts.value = result.ratingsCounts;
      }

      final products = result.products;
      final isLastPage = products.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(products);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(products, nextPageKey);
      }
    } catch (error, stackTrace) {
      hasError.value = true;
      errorMessage.value = error.toString();
      pagingController.error = error;

      // Print detailed error to console
      print('❌ Error fetching products (page $pageKey):');
      print('Error: $error');
      print('StackTrace: $stackTrace');
    }
  }

  // Refresh pagination (used by debounced search)
  void _refreshPagination() {
    pagingController.refresh();
  }

  // Update search query (will trigger debounced search)
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Clear search
  void clearSearch() {
    searchQuery.value = '';
    pagingController.refresh();
  }

  // Refresh products (for pull to refresh)
  void refreshProducts() {
    pagingController.refresh();
  }

  // Retry on error
  void retry() {
    hasError.value = false;
    errorMessage.value = '';
    pagingController.retryLastFailedRequest();
  }
}
