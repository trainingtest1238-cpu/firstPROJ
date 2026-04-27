import 'package:first/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());
  Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F4F1),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                child: Image.asset(
                  fit: BoxFit.fitWidth,
                  height: 200,
                  'lib/assets/images/Layer_1.png',
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),

                child: Text(
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color(0xFFB6A48A).withOpacity(0.7),
                  ),

                  textAlign: TextAlign.start,
                  'splash_fresh_bakery'.tr,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),

                child: Text(
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color(0xFFB6A48A).withOpacity(0.7),
                  ),

                  textAlign: TextAlign.start,
                  'splash_delivery'.tr,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Image.asset('lib/assets/images/powered_by_1.png'),
            ),
          ),
        ],
      ),
    );
  }
}
