import 'package:first/controllers/search_controller.dart';
import 'package:first/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final SearchXController controller = Get.find();
    final theme = Theme.of(context);

    return Obx(() {
      final isSelected = controller.selectedCategory.value == label;

      return GestureDetector(
        onTap: () => controller.selectCategory(label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : const Color(0xFFE4E0D8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected ? AppColors.white : AppColors.textPrimary,
            ),
          ),
        ),
      );
    });
  }
}
