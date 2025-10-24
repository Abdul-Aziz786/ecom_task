import 'package:get/get.dart';
import '../presentation/pages/splash_page.dart';
import '../presentation/pages/product_list_page.dart';
import '../presentation/pages/product/product_detail_page.dart';
import '../presentation/pages/search_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
    GetPage(name: AppRoutes.productList, page: () => const ProductListPage()),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
    ),
    GetPage(name: AppRoutes.search, page: () => const SearchPage()),
  ];
}
