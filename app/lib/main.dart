import 'package:first/bindings/home_binding.dart';
import 'package:first/controllers/language_controller.dart';
import 'package:first/controllers/thisUserController.dart';
import 'package:first/core/theme/app_theme.dart';
import 'package:first/pages/Splash.dart';
import 'package:first/pages/homepage/homapage.dart';
import 'package:first/pages/homepage/widgets/about_us.dart';
import 'package:first/pages/homepage/widgets/account_info.dart';
import 'package:first/pages/homepage/widgets/item_details.dart';
import 'package:first/pages/homepage/widgets/myaccount.dart';
import 'package:first/pages/homepage/widgets/test.dart';
import 'package:first/pages/homepage/widgets/test_2.dart';
import 'package:first/pages/homepage/widgets/users_page.dart';
import 'package:first/pages/login_page/login.dart';
import 'package:first/pages/login_page/otp.dart';
import 'package:first/pages/login_page/register.dart';
import 'package:first/pages/searshpage/searchpage.dart';
import 'package:first/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:first/db_healper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHealper().initDB();
  Get.put(Thisusercontroller());

  runApp(const AlrayaApp());
}

class AlrayaApp extends StatelessWidget {
  const AlrayaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController langController = Get.put(LanguageController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      translations: AppTranslations(),
      locale: langController.savedLocale,
      fallbackLocale: const Locale('en', 'US'),

      builder: (context, child) {
        final isArabic = Get.locale?.languageCode == 'ar';
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },

      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => Splash()),
        GetPage(name: '/home', page: () => Homapage(), binding: HomeBinding()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/search', page: () => Searchpage()),
        GetPage(name: '/details', page: () => ItemDetails()),
        GetPage(name: '/myaccount', page: () => MyAccount()),
        GetPage(name: '/aboutus', page: () => AboutUs()),
        GetPage(name: '/account_info', page: () => AccountInfo()),
        GetPage(name: '/test', page: () => Test()),
        GetPage(name: '/test2', page: () => Test2()),
        GetPage(name: '/register', page: () => Register()),
        GetPage(name: '/users', page: () => UsersPage()),
        GetPage(name: '/otp', page: () => OtpPage()),
      ],
    );
  }
}
