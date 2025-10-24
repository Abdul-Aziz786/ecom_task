import 'package:ecom/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../data/models/product_model.dart';
import '../../controllers/product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final ProductDetailController _controller = Get.put(
    ProductDetailController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = _controller.product.value;

      if (_controller.isLoading.value) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
          body: const Center(child: CircularProgressIndicator()),
        );
      }

      if (_controller.hasError.value || product == null) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  _controller.hasError.value
                      ? 'Failed to load product'
                      : 'Product not found',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _controller.retry(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Scrollable content
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  // expandedHeight: 400,
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.share_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () => _controller.shareProduct(),
                      ),
                    ),
                    Obx(
                      () => Container(
                        margin: const EdgeInsets.only(
                          right: 8,
                          top: 8,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            _controller.isFavorite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _controller.isFavorite.value
                                ? Colors.red
                                : Colors.black,
                          ),
                          onPressed: () => _controller.toggleFavorite(),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductHeader(product),
                      _buildRatingSection(product),
                      _buildPriceSection(product),
                    ],
                  ),
                ),

                // Product details
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 7),
                      _buildImageCarousel(product),
                      _buildVariantSelector(product),
                      const Divider(
                        height: 1,
                        thickness: 8,
                        color: Color(0xFFF5F5F5),
                      ),
                      _buildDetailsSection(product),
                      const Divider(
                        height: 2,
                        thickness: 8,
                        color: Color(0xFFF5F5F5),
                      ),
                      _buildDescriptionSection(product),

                      _buildReviewsSection(product),
                      const SizedBox(height: 100), // Space for bottom bar
                    ],
                  ),
                ),
              ],
            ),

            // Sticky bottom bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomBar(product),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildImageCarousel(Product product) {
    final images = product.images;

    if (images.isEmpty) {
      return Container(
        height: 400,
        color: Colors.grey[100],
        child: const Center(
          child: Icon(Icons.image_outlined, size: 100, color: Colors.grey),
        ),
      );
    }

    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              imageUrl: '${AppConstants.imageBaseUrl}/${images[index]}',
              fit: BoxFit.contain,
              width: double.infinity,
              placeholder: (context, url) => Container(
                color: Colors.grey[100],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[100],
                child: const Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 400,
            viewportFraction: 1.0,
            enableInfiniteScroll: images.length > 1,
            autoPlay: false,
            onPageChanged: (index, reason) {
              _controller.updateImageIndex(index);
            },
          ),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.currentImageIndex.value == entry.key
                          ? Colors.black
                          : Colors.black26,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProductHeader(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand/Category
          if (product.brand != null || product.categoryName.isNotEmpty)
            Text(
              product.brand?.title?.toUpperCase() ??
                  product.categoryName.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                letterSpacing: 1,
              ),
            ),
          const SizedBox(height: 4),

          // Product Title
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          // Subtitle if available
          if (product.subtitle != null && product.subtitle!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              product.subtitle!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingSection(Product product) {
    if (product.rating <= 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // decoration: BoxDecoration(
      //   border: Border(
      //     top: BorderSide(color: Colors.grey[200]!),
      //     bottom: BorderSide(color: Colors.grey[200]!),
      //   ),
      // ),
      child: Row(
        children: [
          RatingBarIndicator(
            rating: product.rating,
            itemBuilder: (context, index) =>
                const Icon(Icons.star, color: Colors.black),
            itemCount: 5,
            itemSize: 18.0,
            unratedColor: Colors.grey[300],
          ),
          const SizedBox(width: 12),
          Text(
            '${product.rating.toStringAsFixed(1)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 4),
          Text(
            '(${product.reviewCount} ${product.reviewCount == 1 ? 'review' : 'reviews'})',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          // const Spacer(),
          // Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }

  Widget _buildPriceSection(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${product.effectivePrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              if (product.hasDiscount &&
                  product.variants != null &&
                  product.variants!.isNotEmpty) ...[
                const SizedBox(width: 12),
                Text(
                  '\$${(product.variants!.first.originalPrice ?? 0).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${product.discountPercentage}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Stock status
          Row(
            children: [
              Icon(
                product.isAvailable ? Icons.check_circle : Icons.cancel,
                size: 18,
                color: product.isAvailable ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 6),
              Text(
                product.isAvailable ? 'In Stock' : 'Out of Stock',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: product.isAvailable
                      ? Colors.green[700]
                      : Colors.red[700],
                ),
              ),
              if (product.isAvailable &&
                  product.stock > 0 &&
                  product.stock < 10) ...[
                const SizedBox(width: 8),
                Text(
                  '• Only ${product.stock} left',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVariantSelector(Product product) {
    final sizes = product.sizes;
    final colors = product.colors;

    if ((sizes == null || sizes.isEmpty) &&
        (colors == null || colors.isEmpty)) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Size selector
          if (sizes != null && sizes.isNotEmpty) ...[
            Row(
              children: [
                const Text(
                  'Size',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Get.snackbar(
                      'Size Guide',
                      'Size guide coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  child: const Text('Size Guide'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(
              () => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: sizes.map((size) {
                  final isSelected = _controller.selectedSize.value == size;
                  return InkWell(
                    onTap: () => _controller.selectSize(size),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isSelected ? Colors.black : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Color selector
          if (colors != null && colors.isNotEmpty) ...[
            Row(
              children: [
                const Text(
                  'Color',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => Text(
                    _controller.selectedColor.value ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: colors.map((color) {
                  final isSelected = _controller.selectedColor.value == color;
                  return InkWell(
                    onTap: () => _controller.selectColor(color),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _getColorFromName(color),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Color _getColorFromName(String colorName) {
    final name = colorName.toLowerCase();
    if (name.contains('red')) return Colors.red;
    if (name.contains('blue')) return Colors.blue;
    if (name.contains('green')) return Colors.green;
    if (name.contains('yellow')) return Colors.yellow;
    if (name.contains('black')) return Colors.black;
    if (name.contains('white')) return Colors.white;
    if (name.contains('grey') || name.contains('gray')) return Colors.grey;
    if (name.contains('pink')) return Colors.pink;
    if (name.contains('purple')) return Colors.purple;
    if (name.contains('orange')) return Colors.orange;
    return Colors.grey;
  }

  Widget _buildDescriptionSection(Product product) {
    if (product.description == null || product.description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            product.description!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(Product product) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('SKU', product.id ?? 'N/A'),
          if (product.brand != null)
            _buildDetailRow('Brand', product.brand!.title ?? 'N/A'),
          _buildDetailRow('Category', product.categoryName),
          if (product.weight != null)
            _buildDetailRow('Weight', product.weight!),
          if (product.material != null)
            _buildDetailRow('Material', product.material!),
          _buildDetailRow(
            'Availability',
            product.isAvailable ? 'In Stock' : 'Out of Stock',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    'Reviews',
                    'All reviews coming soon',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: const Text('See All'),
              ),
            ],
          ),
          if (product.rating > 0)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: product.rating,
                              itemBuilder: (context, index) =>
                                  const Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 20.0,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Based on ${product.reviewCount} reviews',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No reviews yet',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            children: [
              // Quantity selector
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => _controller.decreaseQuantity(),
                      icon: const Icon(Icons.remove, size: 20),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Obx(
                        () => Text(
                          '${_controller.quantity.value}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _controller.increaseQuantity(),
                      icon: const Icon(Icons.add, size: 20),
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Add to cart button
              Expanded(
                child: ElevatedButton(
                  onPressed: product.isAvailable
                      ? () => _controller.addToCart()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    product.isAvailable ? 'ADD TO BAG' : 'OUT OF STOCK',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
