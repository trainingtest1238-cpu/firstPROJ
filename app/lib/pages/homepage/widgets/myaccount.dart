import 'package:first/controllers/thisUserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/controllers/language_controller.dart';
import 'package:first/core/theme/app_colors.dart';

class MyAccount extends StatelessWidget {
  MyAccount({super.key});
  final Thisusercontroller ThisUserController = Get.find<Thisusercontroller>();
  @override
  Widget build(BuildContext context) {
    final LanguageController languageController =
        Get.find<LanguageController>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(width: double.infinity, height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 30, end: 10),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(800),
                  ),
                  child: Center(
                    child: Text(
                      'A',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                '${ThisUserController.currentUser['firstName'] ?? ''} ${ThisUserController.currentUser['lastName'] ?? ''}',
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 30, width: double.infinity),
          TextButton(
            onPressed: () {
              Get.toNamed('/account_info');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(
                    Icons.person_2_outlined,
                    size: 30,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'myaccount_title'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30, width: double.infinity),
          TextButton(
            onPressed: () {
              Get.toNamed('/test2');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(
                    Icons.gps_fixed_outlined,
                    size: 30,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'myaccount_delivery_address'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30, width: double.infinity),
          TextButton(
            onPressed: () {
              Get.toNamed('/test');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(Icons.list, size: 30, color: AppColors.primary),
                ),
                Text(
                  'myaccount_previous_orders'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30, width: double.infinity),
          TextButton(
            onPressed: () {
              Get.toNamed('/users');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(Icons.wallet, size: 30, color: AppColors.primary),
                ),
                Text(
                  'myaccount_wallet'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30, width: double.infinity),
          TextButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  size: 26,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  'myaccount_choose_language'.tr,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextButton(
                                  onPressed: () {
                                    languageController.changeLanguage(
                                      'en',
                                      'US',
                                    );
                                    Get.back();
                                  },
                                  child: Text(
                                    'English',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: TextButton(
                                  onPressed: () {
                                    languageController.changeLanguage(
                                      'ar',
                                      'AR',
                                    );
                                    Get.back();
                                  },
                                  child: Text(
                                    'العربية',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(
                    Icons.language,
                    size: 30,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'myaccount_language'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30, width: double.infinity),
          TextButton(
            onPressed: () {
              Get.toNamed('/aboutus');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(Icons.help, size: 30, color: AppColors.primary),
                ),
                Text(
                  'myaccount_about_us'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30, width: double.infinity),
          TextButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  title: Text(
                    textAlign: TextAlign.center,
                    'myaccount_logout'.tr,
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  content: Text(
                    'myaccount_logout_confirm'.tr,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.accent,
                      ),
                      onPressed: () {
                        Get.back();
                        Get.offAllNamed('/login');
                      },
                      child: Text(
                        'myaccount_logout'.tr,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                    const SizedBox(width: 35),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'myaccount_cancel'.tr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 15, left: 10),
                  child: Icon(Icons.logout, size: 30, color: AppColors.primary),
                ),
                Text(
                  'myaccount_logout'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
