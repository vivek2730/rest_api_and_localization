import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_and_localization/app/translations/translation_service.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,

      // 🌐 Localization setup
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),

      // 🗺 Routing setup
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,

      // 💡 Optional: Theming
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
      ),
    );
  }
}
