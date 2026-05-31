import 'package:first/controllers/imagepickercontroller.dart';
import 'package:first/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/services/http_service.dart';
import 'package:first/controllers/thisUserController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final TextEditingController otpController = TextEditingController();
  final Thisusercontroller userController = Get.find();
  final ImagePickerController controller = Get.put(ImagePickerController());
  final LocationController _controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final userId = args["userId"];

    return Scaffold(
      appBar: AppBar(title: const Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "OTP Code",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  final otp = otpController.text.trim();
                  // ignore: avoid_print
                  print('otp page user id = $userId');
                  // ignore: avoid_print
                  print('otp page otp = $otp');
                  try {
                    final res = await HttpService().postRequest(
                      "${HttpService().url}/api/users/verify-otp",
                      {"userId": userId, "otpCode": otp},
                    );
                    print(res);
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('token', res['token']);
                    await prefs.setInt("userid", res["userid"]);
                    await prefs.setString("firstName", res["firstName"]);
                    await prefs.setString("lastName", res["lastName"]);
                    await prefs.setString("phone", res["phone"]);
                    userController.setUser({
                      "userid": res["userid"],
                      "firstName": res["firstName"],
                      "lastName": res["lastName"],
                      "phone": res["phone"],
                    });

                    Get.offAllNamed('/home');
                  } catch (e) {
                    Get.snackbar("Error", "Invalid OTP");
                  }
                },
                child: const Text("Verify"),
              ),
              TextButton(
                onPressed: () async {
                  final args = Get.arguments;
                  final phone = args["phone"];
                  Map<String, dynamic> body = {"phone": phone};
                  try {
                    final res = await HttpService().postRequest(
                      "${HttpService().url}/api/users/resend-otp",
                      body,
                    );

                    print("NEW OTP = ${res['otp']}");

                    Get.snackbar("Done", "OTP resent successfully");
                  } catch (e) {
                    print('phone nnumber isLoading.value ?null $phone');
                    print('resend error = $e');
                    Get.snackbar("Error", "Failed to resend OTP");
                  }
                },
                child: const Text("Resend OTP"),
              ),
              SizedBox(height: 40),
              Center(
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.selectedImage.value != null
                          ? Image.file(
                              controller.selectedImage.value!,
                              height: 100,
                            )
                          : const Text('no image selected'),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: controller.takePhoto,
                        icon: Icon(Icons.camera_alt),
                        label: Text("take a photo"),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: controller.pickPhoto,
                        icon: Icon(Icons.photo),
                        label: Text("pick a photo from galary"),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(_controller.locationText.value),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _controller.isLoading.value
                                    ? null
                                    : _controller.getUserLocation,
                                child: _controller.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text('Get My Location'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
