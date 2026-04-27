import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/models/together.dart';
import 'package:first/core/theme/app_colors.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({super.key});
  final Map<String, dynamic>? product = Get.arguments;
  final RxString selectedSize = ''.obs;
  final RxInt quantity = 1.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: AppColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'item_price'.tr,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'item_add_to_cart'.tr,
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () => quantity.value++,
                  icon: const Icon(Icons.add, color: AppColors.primary),
                ),
                Obx(
                  () => Text(
                    quantity.value.toString(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (quantity.value > 1) quantity.value--;
                  },
                  icon: const Icon(Icons.remove, color: AppColors.primary),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    right: 20,
                    left: 20,
                    bottom: 20,
                  ),
                  child: Image.asset(
                    "lib/assets/images/${product?['productImage']}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_rounded),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 150),
              child: Text(
                product?['productName'],
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 70),
              child: Text(
                textAlign: TextAlign.right,
                'item_description'.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black.withOpacity(0.4),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  textAlign: TextAlign.right,
                  'item_unit_choice'.tr,
                  style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 60,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'item_required'.tr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10, start: 20),
              child: Text(
                textAlign: TextAlign.right,
                'item_choose_one'.tr,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20, start: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () => selectedSize.value = '1kg',
                    icon: Obx(
                      () => Icon(
                        selectedSize.value == '1kg'
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: AppColors.primary,
                      ),
                    ),
                    label: Text(
                      'item_1kg'.tr,
                      textDirection: TextDirection.rtl,
                      style: theme.textTheme.bodyMedium,
                    ),
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton.icon(
                    onPressed: () => selectedSize.value = '500g',
                    icon: Obx(
                      () => Icon(
                        selectedSize.value == '500g'
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: AppColors.primary,
                      ),
                    ),
                    label: Text(
                      'item_500g'.tr,
                      textDirection: TextDirection.rtl,
                      style: theme.textTheme.bodyMedium,
                    ),
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, top: 30),
              child: Text(
                textAlign: TextAlign.right,
                'item_order_together'.tr,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: togetherDataList.length,
                itemBuilder: (context, index) {
                  final item = togetherDataList[index];
                  return Container(
                    width: 150,
                    margin: const EdgeInsetsDirectional.only(
                      start: 10,
                      top: 10,
                      end: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          item.image,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          item.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          item.price,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
