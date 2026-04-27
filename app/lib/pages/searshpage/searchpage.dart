import 'package:first/controllers/search_controller.dart';
import 'package:first/core/theme/app_colors.dart';
import 'package:first/pages/searshpage/widgets/category_chip.dart';
import 'package:first/pages/searshpage/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Searchpage extends StatelessWidget {
  Searchpage({super.key});

  final SearchXController controller = Get.put(SearchXController());

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode == 'ar';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              _searchBar(context, isArabic),
              const SizedBox(height: 24),
              _categoryChips(),
              const SizedBox(height: 24),
              _itemsSection(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context, bool isArabic) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textPrimary,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                onChanged: (value) {
                  controller.searchProducts(value);
                },
                textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'search_hint'.tr,
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: controller.categories
              .map(
                (label) => Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CategoryChip(label: label),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _itemsSection(BuildContext context) {
    return Obx(() {
      if (controller.selectedCategory.value != null &&
          controller.results.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.results.length,
            itemBuilder: (context, index) {
              final item = controller.results[index];
              return ItemCard(item: item);
            },
          ),
        );
      } else {
        return _defaultContent(context);
      }
    });
  }

  Widget _defaultContent(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'search_recent'.tr,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 12),
          Obx(
            () => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.recentSearches
                  .map(
                    (search) => GestureDetector(
                      onTap: () => controller.selectCategory(search),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4E0D8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(search, style: theme.textTheme.bodyMedium),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.history,
                              size: 16,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'search_best_selling'.tr,
              style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.trending.map((label) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4E0D8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        label,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.north_west,
                        color: Colors.black54,
                        size: 16,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
