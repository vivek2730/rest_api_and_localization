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

  /// Returns a placeholder image URL
  String getImageUrl(String name) {
    return 'https://via.placeholder.com/150';
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
