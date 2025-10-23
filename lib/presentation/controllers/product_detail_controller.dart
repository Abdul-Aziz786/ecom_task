import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductDetailController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  // Observable states
  final Rx<Product?> product = Rx<Product?>(null);
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  // UI states
  final RxInt currentImageIndex = 0.obs;
  final Rx<String?> selectedSize = Rx<String?>(null);
  final Rx<String?> selectedColor = Rx<String?>(null);
  final RxInt quantity = 1.obs;
  final RxBool isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Get product from arguments
    final Product? passedProduct = Get.arguments as Product?;

    if (passedProduct != null) {
      // Set initial product for immediate display
      // product.value = passedProduct;

      // Set initial selections
      selectedSize.value = passedProduct.sizes?.first;
      selectedColor.value = passedProduct.colors?.first;

      // Load full product details
      loadProductDetails(passedProduct.handle);
    }
  }

  // Load product details from API
  Future<void> loadProductDetails(String handle) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final productData = await _productRepository.getProductByHandler(handle);
      product.value = productData;

      // Update selections if not already set
      final sizes = productData?.sizes;
      if (selectedSize.value == null && sizes != null && sizes.isNotEmpty) {
        selectedSize.value = sizes.first;
      }

      final colors = productData?.colors;
      if (selectedColor.value == null && colors != null && colors.isNotEmpty) {
        selectedColor.value = colors.first;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Update image index
  void updateImageIndex(int index) {
    currentImageIndex.value = index;
  }

  // Select size
  void selectSize(String size) {
    selectedSize.value = size;
  }

  // Select color
  void selectColor(String color) {
    selectedColor.value = color;
  }

  // Increase quantity
  void increaseQuantity() {
    quantity.value++;
  }

  // Decrease quantity
  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  // Toggle favorite
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    Get.snackbar(
      isFavorite.value ? 'Added to Wishlist' : 'Removed from Wishlist',
      product.value?.name ?? '',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Share product
  void shareProduct() {
    Get.snackbar(
      'Share',
      'Share functionality coming soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Add to cart
  void addToCart() {
    if (product.value == null) return;

    Get.snackbar(
      'Added to Cart',
      '${quantity.value}x ${product.value!.name}',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Retry loading
  void retry() {
    if (product.value?.handle != null) {
      loadProductDetails(product.value!.handle);
    }
  }
}
