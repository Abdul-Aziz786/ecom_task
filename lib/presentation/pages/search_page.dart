import 'package:ecom/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart' as app;
import '../../data/models/product_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final app.SearchController _controller = Get.put(app.SearchController());
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Get the initial search text from arguments (from product list page)
    final initialText = Get.arguments;
    if (initialText != null &&
        initialText is String &&
        initialText.isNotEmpty) {
      _textController.text = initialText;
      // Fetch suggestions for the initial text
      _controller.fetchSuggestions(initialText);
    }

    // Auto-focus search field when page opens
    Future.delayed(const Duration(milliseconds: 100), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            _buildSearchBar(),

            // Search results
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }

                if (_controller.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      _controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final data = _controller.suggestionData.value;
                if (data == null) {
                  return _buildEmptyState();
                }

                return _buildSearchResults(data);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back, size: 24),
          ),
          const SizedBox(width: 12),

          // Search field
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    _controller.fetchSuggestions(value);
                  } else {
                    _controller.clearSearch();
                  }
                },
                onSubmitted: (value) {
                  // Submit search and return to product list page
                  if (value.trim().isNotEmpty) {
                    Get.back(result: value.trim());
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 22,
                  ),
                  suffixIcon: Obx(
                    () => _controller.searchQuery.value.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _textController.clear();
                              _controller.clearSearch();
                              // Return empty string to clear product list search
                              Get.back(result: '');
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // Submit/Search button
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              // Submit search and return to product list page
              final searchText = _textController.text.trim();
              if (searchText.isNotEmpty) {
                Get.back(result: searchText);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Search for products',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start typing to see suggestions',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(data) {
    final suggestions = data.suggestions ?? [];
    final products = data.products ?? [];

    // Group products by category
    final Map<String, List<Product>> groupedProducts = {};
    for (final product in products) {
      final categories = product.productCategories ?? [];
      if (categories.isEmpty) {
        groupedProducts.putIfAbsent('Other', () => []).add(product);
      } else {
        for (final category in categories) {
          final categoryName = category.category?.name ?? 'Other';
          groupedProducts.putIfAbsent(categoryName, () => []).add(product);
        }
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Suggestions section
          if (suggestions.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Text(
                'Search Suggestions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            ...suggestions.map(
              (suggestion) => _buildSuggestionItem(suggestion),
            ),
            const SizedBox(height: 8),
          ],

          // Product Suggestions section with categories
          if (groupedProducts.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Text(
                'Product Suggestions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            // Show products grouped by category
            ...groupedProducts.entries.map(
              (entry) => _buildCategorySection(entry.key, entry.value),
            ),
          ],

          // Trending Categories (placeholder based on image)
          if (suggestions.isEmpty && products.isEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Text(
                'Trending Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            _buildCategoryChips(),
          ],
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String suggestion) {
    return InkWell(
      onTap: () {
        // Return the selected suggestion to the product list page
        Get.back(result: suggestion);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.search, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                suggestion,
                style: const TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.north_west, size: 18, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String categoryName, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            categoryName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        ...products.map((product) => _buildProductItem(product)),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  Widget _buildProductItem(Product product) {
    return InkWell(
      onTap: () {
        Get.toNamed('/product-detail', arguments: product);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Product image
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product.thumbnail != null
                    ? Image.network(
                        '${AppConstants.imageBaseUrl}/${product.thumbnail}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.image, color: Colors.grey[400]),
                      )
                    : Icon(Icons.image, color: Colors.grey[400]),
              ),
            ),
            const SizedBox(width: 12),

            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? 'Product',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.brand?.title != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      product.brand!.title!,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    // Placeholder categories based on the image
    final categories = [
      'Skincare',
      'Makeup',
      'Hair Care',
      'Fragrance',
      'Body Care',
      'Tools & Brushes',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: categories.map((category) {
          return InkWell(
            onTap: () {
              // Return the selected category to the product list page
              Get.back(result: category);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
