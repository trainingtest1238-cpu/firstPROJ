import 'package:flutter/material.dart';
import 'package:first/core/theme/app_colors.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final bool isArabic;
  final void Function(int index) onTap;

  const BottomNavBar({super.key, required this.isArabic, required this.onTap});

  Widget _bottomNavItem({
    required BuildContext context,
    required double width,
    required String label,
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          minimumSize: const Size(0, 36),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        icon: const SizedBox.shrink(),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: theme.textTheme.bodyMedium),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 6, right: 6),
              child: ImageIcon(
                AssetImage(imagePath),
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;

    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white60,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _bottomNavItem(
            context: context,
            width: width,
            label: 'home_main'.tr,
            imagePath: 'lib/assets/images/home.png',
            onPressed: () => onTap(0),
          ),
          _bottomNavItem(
            context: context,
            width: width,
            label: 'home_orders'.tr,
            imagePath: 'lib/assets/images/order.png',
            onPressed: () => onTap(1),
          ),
          _bottomNavItem(
            context: context,
            width: width,
            label: 'home_account'.tr,
            imagePath: 'lib/assets/images/person.png',
            onPressed: () => onTap(2),
          ),
        ],
      ),
    );
  }
}
