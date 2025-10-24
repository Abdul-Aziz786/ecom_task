import 'package:get/get.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/models/search_suggestion_model.dart';

class SearchController extends GetxController {
  final ProductRemoteDataSource _dataSource = ProductRemoteDataSource();

  // Observable state
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final Rx<SearchSuggestionData?> suggestionData = Rx<SearchSuggestionData?>(
    null,
  );
  final RxString errorMessage = ''.obs;

  /// Fetch search suggestions based on query
  Future<void> fetchSuggestions(String query) async {
    if (query.trim().isEmpty) {
      suggestionData.value = null;
      searchQuery.value = '';
      return;
    }

    try {
      searchQuery.value = query;
      isLoading.value = true;
      errorMessage.value = '';

      final data = await _dataSource.getSearchSuggestions(query);
      suggestionData.value = data;
    } catch (e, stackTrace) {
      print('❌ Error fetching search suggestions:');
      print('Query: $query');
      print('Error: $e');
      print('StackTrace: $stackTrace');
      errorMessage.value = 'Failed to load suggestions';
      suggestionData.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear search and results
  void clearSearch() {
    searchQuery.value = '';
    suggestionData.value = null;
    errorMessage.value = '';
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}
