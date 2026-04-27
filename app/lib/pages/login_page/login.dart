import 'package:first/controllers/thisUserController.dart';
import 'package:first/core/theme/app_colors.dart';
import 'package:first/pages/login_page/widget/authtabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final Thisusercontroller controller = Get.find<Thisusercontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset('lib/assets/images/Layer_1.png'),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: AuthTabs(isLogin: true),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xffE8E8E8),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundImage: AssetImage(
                          'lib/assets/images/jordan_flag.png',
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 1,
                        height: 28,
                        color: const Color(0xffE0E0E0),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: TextField(
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                          onChanged: controller.onLoginPhoneChanged,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],

                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: Text(
                              'phone number',
                              style: TextStyle(color: Colors.grey),
                            ),
                            hintText: '07XXXXXXXX',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 250),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      // ignore: deprecated_member_use
                      disabledBackgroundColor: AppColors.accent.withOpacity(
                        0.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                    onPressed: controller.isPhoneValid.value
                        ? controller.loginUser
                        : null,

                    child: Center(child: Text('login_button'.tr)),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                      indent: 50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('login_or'.tr),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                      endIndent: 50,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('lib/assets/images/google.png'),
                        Text(
                          'login_continue_google'.tr,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
