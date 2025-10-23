import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/models/api_response.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  final RxList<Product> allProducts = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<Product?> selectedProduct = Rx<Product?>(null);

  // Search metadata
  final RxList<BrandSummary> brands = <BrandSummary>[].obs;
  final RxList<AttributeSummary> attributes = <AttributeSummary>[].obs;
  final Rx<Map<String, int>?> ratingsCounts = Rx<Map<String, int>?>(null);

  int currentPage = 1;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  // Load initial data
  Future<void> loadInitialData() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      await loadAllProducts();
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Load all products
  Future<void> loadAllProducts({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      hasMore = true;
      allProducts.clear();
    }

    try {
      final result = await _productRepository.searchProducts(page: currentPage);

      if (result.products.isEmpty) {
        hasMore = false;
      } else {
        allProducts.addAll(result.products);

        // Update search metadata
        if (result.brands != null) brands.value = result.brands!;
        if (result.attributes != null) attributes.value = result.attributes!;
        if (result.ratingsCounts != null)
          ratingsCounts.value = result.ratingsCounts;

        currentPage++;
      }
    } catch (e, st) {
      print(e);
      print(st);
      hasError.value = true;
      errorMessage.value = e.toString();
    }
  }

  // Get product details by handler
  Future<void> getProductDetails(String handler) async {
    try {
      isLoading.value = true;
      final product = await _productRepository.getProductByHandler(handler);
      selectedProduct.value = product;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Load more products for infinite scroll
  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore) return;

    isLoadingMore.value = true;
    await loadAllProducts(refresh: false);
    isLoadingMore.value = false;
  }

  // Refresh products
  Future<void> refreshProducts() async {
    currentPage = 1;
    hasMore = true;
    allProducts.clear();
    await loadInitialData();
  }

  // Retry on error
  Future<void> retry() async {
    hasError.value = false;
    errorMessage.value = '';
    await loadInitialData();
  }
}
