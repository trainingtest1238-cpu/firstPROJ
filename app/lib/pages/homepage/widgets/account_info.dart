import 'package:first/controllers/thisUserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/pages/homepage/widgets/buildfield.dart';
import 'package:first/core/theme/app_colors.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({super.key});

  final RxBool isEditable = false.obs;
  final RxBool onOrOff = false.obs;

  final Thisusercontroller ThisUserController = Get.find<Thisusercontroller>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: TextButton(
                      onPressed: () => isEditable.value = !isEditable.value,
                      child: Text(
                        isEditable.value ? '' : 'account_edit'.tr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'account_info_title'.tr,
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    BuildFieldWidget(
                      controller: ThisUserController.emailController,
                      label: 'account_email'.tr,
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),
                    BuildFieldWidget(
                      controller: ThisUserController.phoneController,
                      label: 'account_mobile'.tr,
                      readOnly: true,
                    ),
                    const SizedBox(height: 12),
                    BuildFieldWidget(
                      controller: ThisUserController.firstNameController,
                      label: 'account_first_name'.tr,
                      readOnly: !isEditable.value,
                      showIcon: !isEditable.value,
                    ),
                    const SizedBox(height: 12),
                    BuildFieldWidget(
                      controller: ThisUserController.lastNameController,
                      label: 'account_last_name'.tr,
                      readOnly: !isEditable.value,
                      showIcon: !isEditable.value,
                    ),
                    const Divider(
                      endIndent: 10,
                      indent: 10,
                      thickness: 1,
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Switch(
                          value: onOrOff.value,
                          onChanged: (v) {
                            onOrOff.value = !onOrOff.value;
                          },
                          activeTrackColor: Colors.green,
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                          splashRadius: 0,
                        ),
                        Text(
                          'account_guest_user'.tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 230),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () async {
                          if (isEditable.value) {
                            try {
                              await ThisUserController.saveUserData();
                              Get.snackbar(
                                'account_done'.tr,
                                'account_changes_saved'.tr,
                                backgroundColor: AppColors.primary,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              isEditable.value = false;
                            } catch (e) {
                              // ignore: avoid_print
                              print(e);
                              Get.snackbar(
                                'Error',
                                'Something went wrong',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: isEditable.value
                              ? AppColors.primary
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Text(
                          isEditable.value
                              ? 'account_save'.tr
                              : 'account_delete'.tr,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isEditable.value ? Colors.white : Colors.red,
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
      ),
    );
  }
}
