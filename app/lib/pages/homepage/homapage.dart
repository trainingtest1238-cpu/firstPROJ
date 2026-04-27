import 'package:first/controllers/home_controller.dart';
import 'package:first/controllers/thisUserController.dart';
import 'package:first/core/theme/app_colors.dart';
import 'package:first/pages/homepage/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homapage extends GetView<HomeController> {
  const Homapage({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';
    final theme = Theme.of(context);
    // ignore: non_constant_identifier_names
    final Thisusercontroller ThisUserController =
        Get.find<Thisusercontroller>();

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        isArabic: isArabic,
        onTap: (index) {
          if (index == 2) {
            Get.toNamed('/myaccount');
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 15,
                right: 20,
                left: 20,
              ),
              child: GestureDetector(
                onTap: () => Get.toNamed('/search'),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintTextDirection: isArabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      hintText: 'home_search'.tr,
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        color: Colors.grey[400],
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: Row(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Text(
                      '${'home_greeting'.tr}${ThisUserController.currentUser['firstName'] ?? ''}',
                      style: theme.textTheme.titleLarge,
                      textDirection: isArabic
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textAlign: isArabic ? TextAlign.right : TextAlign.left,
                    );
                  }),
                  Image.asset('lib/assets/images/Group 23.png'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Text(
                    'home_deliver_to'.tr,
                    textDirection: isArabic
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  'home_address'.tr,
                  textDirection: isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: theme.textTheme.titleMedium,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5, left: 5),
                    child: Image.asset('lib/assets/images/Frame 196.png'),
                  ),
                  hintText: 'home_branch'.tr,
                  hintStyle: theme.textTheme.bodyMedium,
                  hintTextDirection: isArabic
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  prefixIcon: const Icon(Icons.keyboard_arrow_down),
                  prefixIconConstraints: const BoxConstraints(),
                  suffixIconConstraints: const BoxConstraints(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Image.asset('lib/assets/images/Frame 239.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: Row(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home_categories'.tr,
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: 14),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'home_show_all'.tr,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.accent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Directionality(
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: SizedBox(
                  height: 180,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(1000),
                        onTap: () {},
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                "lib/assets/images/${category['categoryImage']}",
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 15,

                              child: Text(
                                textAlign: TextAlign.center,
                                category['categoryName'],
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                right: 20,
                bottom: 15,
                left: 20,
              ),
              child: Text(
                'home_featured'.tr,
                style: theme.textTheme.titleMedium,
              ),
            ),
            Obx(
              () => SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.featuredProducts.length,
                  itemBuilder: (context, index) {
                    final special = controller.featuredProducts[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: InkWell(
                        onTap: () =>
                            Get.toNamed('/details', arguments: special),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                start: 17,
                                end: 17,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "lib/assets/images/${special['productImage']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12, left: 70),
                              child: Text(
                                special['productName'],
                                textAlign: TextAlign.right,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 12,
                                start: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    special['productPrice'].toString(),
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontSize: 15),
                                  ),
                                  const SizedBox(width: 90),
                                  const Icon(Icons.add_shopping_cart),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20, start: 20),
              child: Text(
                'home_buy_again'.tr,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 14),
              ),
            ),
            Obx(
              () => SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.buyAgain.length,
                  itemBuilder: (context, index) {
                    final item = controller.buyAgain[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 17,
                                  top: 10,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "lib/assets/images/${item['productImage']}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  top: 12,
                                  start: 20,
                                ),
                                child: Text(
                                  item['productName'],
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 20,
                                  top: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['productPrice'].toString() +
                                          " add git",
                                      textDirection: isArabic
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(Icons.add_shopping_cart),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
