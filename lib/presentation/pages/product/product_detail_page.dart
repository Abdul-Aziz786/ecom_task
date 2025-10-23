import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Product? product;
  int _currentImageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    product = Get.arguments as Product?;

    if (product != null) {
      _selectedSize = product!.sizes?.first;
      _selectedColor = product!.colors?.first;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: const Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCarousel(),
                _buildProductInfo(context),
                _buildOptions(),
                _buildTabBar(),
                _buildTabContent(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? AppColors.error : Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
            Get.snackbar(
              _isFavorite ? 'Added to Wishlist' : 'Removed from Wishlist',
              product!.name,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.black),
          onPressed: () {
            Get.snackbar(
              'Share',
              'Share functionality coming soon',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageCarousel() {
    final images = product!.images;

    if (images.isEmpty) {
      return Container(
        height: 400,
        color: Colors.grey[200],
        child: const Icon(Icons.image, size: 100, color: Colors.grey),
      );
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.error, size: 50),
              ),
            );
          },
          options: CarouselOptions(
            height: 400,
            viewportFraction: 1.0,
            enableInfiniteScroll: images.length > 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentImageIndex == entry.key
                    ? AppColors.primary
                    : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category name as brand
          Text(
            product!.categoryName,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),

          // Product name
          Text(
            product!.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Price and rating
          Row(
            children: [
              Text(
                '\$${product!.effectivePrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              if (product!.hasDiscount)
                Text(
                  '\$${(product!.variants.first.originalPrice).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[600],
                  ),
                ),
              if (product!.hasDiscount) const SizedBox(width: 8),
              if (product!.hasDiscount)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${product!.discountPercentage}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Spacer(),
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                product!.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                ' (${product!.reviewCount})',
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stock status
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: product!.isAvailable ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                product!.isAvailable
                    ? 'In Stock (${product!.stock} available)'
                    : 'Out of Stock',
                style: TextStyle(
                  color: product!.isAvailable ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 16),

          // Size selection
          if (product!.sizes != null && product!.sizes!.isNotEmpty) ...[
            const Text(
              'Select Size',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product!.sizes!.map((size) {
                final isSelected = _selectedSize == size;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSize = size;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Colors.white,
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Color selection
          if (product!.colors != null && product!.colors!.isNotEmpty) ...[
            const Text(
              'Select Color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: product!.colors!.map((color) {
                final isSelected = _selectedColor == color;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.grey[300]!,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Colors.white,
                    ),
                    child: Text(
                      color,
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Quantity selector
          const Text(
            'Quantity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                onPressed: _quantity > 1
                    ? () {
                        setState(() {
                          _quantity--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: AppColors.primary,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primary,
        unselectedLabelColor: Colors.grey,
        indicatorColor: AppColors.primary,
        tabs: const [
          Tab(text: 'Description'),
          Tab(text: 'Specifications'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return SizedBox(
      height: 300,
      child: TabBarView(
        controller: _tabController,
        children: [_buildDescription(), _buildSpecifications()],
      ),
    );
  }

  Widget _buildDescription() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product!.description ?? 'No description available',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecifications() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSpecRow('Product ID', product!.id),
          _buildSpecRow('Category', product!.categoryName),
          _buildSpecRow(
            'Price',
            '\$${product!.effectivePrice.toStringAsFixed(2)}',
          ),
          if (product!.discountPrice != null)
            _buildSpecRow(
              'Original Price',
              '\$${(product!.variants.first.originalPrice).toStringAsFixed(2)}',
            ),
          _buildSpecRow('Rating', '${product!.rating}/5.0'),
          _buildSpecRow('Reviews', '${product!.reviewCount} reviews'),
          _buildSpecRow('Stock', '${product!.stock} units'),
          if (product!.specifications != null)
            ...product!.specifications!.entries.map(
              (entry) => _buildSpecRow(entry.key, entry.value.toString()),
            ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }
}
