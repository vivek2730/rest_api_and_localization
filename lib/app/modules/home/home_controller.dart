import 'package:get/get.dart';
import 'package:rest_api_and_localization/app/data/model/object_model.dart';
import 'package:rest_api_and_localization/app/data/provider/api_provider.dart';

class HomeController extends GetxController {
  final objects = <RestObject>[].obs;
  final isLoading = false.obs;
  final ApiProvider _api = ApiProvider();

  @override
  void onInit() {
    super.onInit();
    fetchObjects();
  }

  /// Maps known product names to valid image URLs
  String getImageUrl(String name) {
    final map = {
      'Apple MacBook Pro 16':
          'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp16-spacegray-select-202110?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1632788573000',
      
      'Samsung Galaxy S21':
          'https://images.samsung.com/is/image/samsung/p6pim/in/sm-g991bzadeua/gallery/in-galaxy-s21-5g-g991-371878-sm-g991bzadeua-368471809',
      
      'Sony WH-1000XM4':
          'https://m.media-amazon.com/images/I/61XNkzGzGvL._SX679_.jpg',
    };

    return map[name] ?? 'https://via.placeholder.com/150';
  }

  /// Fetches data from API and assigns image URLs
  void fetchObjects() async {
    try {
      isLoading.value = true;

      final result = await _api.fetchObjects();

      final updated = result.map((obj) {
        final image = getImageUrl(obj.name);
        return obj.copyWith(imageUrl: image);
      }).toList();

      objects.assignAll(updated);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
