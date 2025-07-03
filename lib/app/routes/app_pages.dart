import 'package:get/get.dart';
import '../modules/home/home_view.dart';
import '../modules/home/home_binding.dart';

class AppRoutes {
  static const home = '/';
}

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
