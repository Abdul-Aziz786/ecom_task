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

  @override
  void onInit() {
    super.onInit();
    // Set up debounce for search query
    debounce(
      searchQuery,
      (_) => _performSearch(),
      time: const Duration(milliseconds: 500),
    );
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> _performSearch() async {
    await _fetchSuggestionsInternal(searchQuery.value);
  }

  Future<void> fetchSuggestions(String query) async {
    searchQuery.value = query;
    await _fetchSuggestionsInternal(query);
  }

  Future<void> _fetchSuggestionsInternal(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      suggestionData.value = null;
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await _dataSource.getSearchSuggestions(trimmedQuery);
      suggestionData.value = data;
    } catch (e, stackTrace) {
      print('❌ Error fetching search suggestions:');
      print('Query: $trimmedQuery');
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
}
