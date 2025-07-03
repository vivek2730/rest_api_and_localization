import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_title'.tr),
        actions: [
          // 🌐 Language Dropdown with padding & fallback
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.black87),
              child: DropdownButton<Locale>(
                value: Get.locale ?? const Locale('en', 'US'),
                underline: const SizedBox(),
                icon: const Icon(Icons.language, color: Colors.white),
                onChanged: (Locale? locale) {
                  if (locale != null) Get.updateLocale(locale);
                },
                items: const [
                  DropdownMenuItem(
                    value: Locale('en', 'US'),
                    child: Text('English', style: TextStyle(color: Colors.white)),
                  ),
                  DropdownMenuItem(
                    value: Locale('hi', 'IN'),
                    child: Text('हिंदी', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchObjects(),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.objects.isEmpty) {
          return Center(child: Text('no_data'.tr));
        }

        return ListView.builder(
          itemCount: controller.objects.length,
          itemBuilder: (_, index) {
            final object = controller.objects[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    object.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 40),
                  ),
                ),
                title: Text(object.name),
                subtitle: Text(object.data.toString()),
              ),
            );
          },
        );
      }),
    );
  }
}
