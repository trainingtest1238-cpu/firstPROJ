import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTabs extends StatelessWidget {
  final bool isLogin;

  const AuthTabs({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab(
          title: 'login_button'.tr,
          isActive: isLogin,
          onTap: () {
            if (!isLogin) {
              Get.offNamed('/login');
            }
          },
        ),
        const SizedBox(width: 16),
        _buildTab(
          title: 'login_register_now'.tr,
          isActive: !isLogin,
          onTap: () {
            if (isLogin) {
              Get.offNamed('/register');
            }
          },
        ),
      ],
    );
  }

  Widget _buildTab({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? Colors.black : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: double.infinity,
              color: isActive ? Colors.black : Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
