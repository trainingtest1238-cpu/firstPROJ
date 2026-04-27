import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/core/theme/app_colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 50,
        width: double.infinity,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: double.infinity, height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 100),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                Center(
                  child: Text(
                    'about_us_title'.tr,
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizedBox(
                  width: 250,
                  height: 140,
                  child: Image.asset(
                    'lib/assets/images/Layer_1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, top: 10),
              child: Text(
                'about_us_history'.tr,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 17, top: 10, left: 17),
              child: Text(
                'about_us_history_body'.tr,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 17, top: 13),
              child: Text(
                'about_us_vision'.tr,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 17, top: 10, left: 17),
              child: Text(
                'about_us_vision_body'.tr,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 17, top: 13),
              child: Text(
                'about_us_contact'.tr,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.only(start: 20, end: 8),
                  child: Icon(Icons.phone_android, color: AppColors.accent),
                ),
                Column(
                  children: [
                    Text('00 962 796304445', style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 20),
                    Text('00 962 795053152', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.only(start: 20, end: 8),
                  child: Icon(Icons.phone, color: AppColors.accent),
                ),
                Text('00962 65300150', style: theme.textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.only(start: 20, end: 8),
                  child: Icon(Icons.fax_outlined, color: AppColors.accent),
                ),
                Text('00962-6-5300151', style: theme.textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 20, end: 10),
                      child: Icon(Icons.camera_alt, color: AppColors.accent),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 20, end: 10),
                      child: Icon(Icons.facebook, color: AppColors.accent),
                    ),
                  ],
                ),
                Text(
                  'Rayabakeryjo',
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 70),
                  child: Image.asset('lib/assets/images/powered_by_1.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
