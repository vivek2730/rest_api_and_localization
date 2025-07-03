import 'package:get/get.dart';
import 'package:rest_api_and_localization/app/data/model/object_model.dart';
import 'package:rest_api_and_localization/app/data/provider/api_provider.dart';

class HomeController extends GetxController{
  final objects = <RestObject>[].obs;
  final isLoading = false.obs;
  final ApiProvider _api = ApiProvider();

  @override
  void onInit() {
    super.onInit();
    fetchObjects();
  }

  String getImageUrl(String name) {
  // Map known product names to image URLs
  final map = {
    'Apple MacBook Pro 16': 'https://store.storeimages.cdn-apple.com/...macbook.jpg',
    'Samsung Galaxy S21': 'https://images.samsung.com/...galaxy-s21.jpg',
    'Sony WH-1000XM4': 'https://cdn.sony.com/....headphones.jpg',
  };

  return map[name] ?? 'https://via.placeholder.com/150'; // fallback image
}

  void fetchObjects() async {
    try {
      isLoading.value = true;
      final result = await _api.fetchObjects();
    final updated = result.map((obj) {
      final image = getImageUrl(obj.name);
      return obj.copyWith(imageUrl: image);
    }).toList();

      objects.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }
}