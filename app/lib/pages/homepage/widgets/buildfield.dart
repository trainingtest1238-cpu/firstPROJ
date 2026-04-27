import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/core/theme/app_colors.dart';

class BuildFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool readOnly;
  final bool showIcon;

  const BuildFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.readOnly,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode == 'ar';
    final theme = Theme.of(context);

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              height: 8,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.only(
              top: 24,
              right: 12,
              left: 12,
              bottom: 8,
            ),
            suffixIcon: showIcon
                ? const Icon(Icons.edit, color: AppColors.primary)
                : null,
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
