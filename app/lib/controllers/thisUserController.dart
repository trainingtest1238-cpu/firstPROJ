// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/http_service.dart';

class Thisusercontroller extends GetxController {
  RxMap<String, dynamic> currentUser = <String, dynamic>{}.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  RxBool isPhoneValid = false.obs;

  void onLoginPhoneChanged(String value) {
    isPhoneValid.value = value.trim().length == 10;
  }

  Future<void> loginUser() async {
    final phone = phoneController.text.trim();

    if (phone.length != 10) {
      Get.snackbar('Error', 'رقم الهاتف يجب أن يكون 10 خانات');
      return;
    }

    try {
      final res = await HttpService().postRequest(
        "${HttpService().url}/api/users/login",
        {"userId": 0, "firstName": "", "lastName": "", "phone": phone},
      );
      print(res);
      Get.toNamed('/otp', arguments: {"userId": res["userId"], "phone": phone});
    } catch (e) {
      Get.toNamed('/register', arguments: phone);
    }
  }

  void setUser(Map<String, dynamic> user) {
    currentUser.value = Map<String, dynamic>.from(user);
    fillFieldsFromUser();
  }

  void fillFieldsFromUser() {
    firstNameController.text = currentUser['firstName'] ?? '';
    lastNameController.text = currentUser['lastName'] ?? '';
    phoneController.text = currentUser['phone'] ?? '';
    emailController.text = '';
  }

  Future<void> saveUserData() async {
    try {
      print(currentUser);
      print(currentUser['usreID']);
      final updatedUser = await HttpService().putRequest(
        "${HttpService().url}/api/users/${currentUser['userID']}",
        {
          "userID": currentUser['userID'],
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "phone": phoneController.text,
        },
      );

      currentUser.value = Map<String, dynamic>.from(updatedUser);
    } catch (e) {
      print("UPDATE ERROR = $e");
      rethrow;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }
}
