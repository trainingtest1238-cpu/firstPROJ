import 'package:first/controllers/thisUserController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final Thisusercontroller userController = Get.find();
  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    await Future.delayed(const Duration(seconds: 4));
    if (token != null) {
      userController.setUser({
        "userID": prefs.getInt("userID"),
        "firstName": prefs.getString("firstName"),
        "lastName": prefs.getString("lastName"),
        "phone": prefs.getString("phone"),
      });
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }
}
