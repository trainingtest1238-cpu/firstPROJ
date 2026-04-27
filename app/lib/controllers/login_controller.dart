import 'package:get/get.dart';

class LoginController extends GetxController {
  RxnString selectedItem = RxnString();
  void setSelectedItem(String? value) {
    selectedItem.value = value;
  }

  void login() {
    Get.offNamed('/home');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
