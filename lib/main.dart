import 'package:classattendanceportal/routes.dart';
import 'package:classattendanceportal/services/translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TranslationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      translations: TranslationService(),
      debugShowCheckedModeBanner: false,
      title: 'Class Attendance Portal',
      theme: ThemeData.dark(),
      builder: (context, child) {
        return ShadTheme(
          data: ShadThemeData(
            brightness: Brightness.light,
            colorScheme: const ShadZincColorScheme.light(),
          ),
          child: child!,
        );
      },
      initialRoute: '/login',
      getPages: AppRouter.routes(),
    );
  }
}
