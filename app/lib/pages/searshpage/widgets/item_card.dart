import 'package:first/core/theme/app_colors.dart';
import 'package:first/models/item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            item.image,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFE4E0D8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.fastfood, color: Colors.grey, size: 50),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${item.price} ${'currency_jod'.tr}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Container(
              width: 26.5,
              height: 26.5,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.add_shopping_cart,
                color: AppColors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
