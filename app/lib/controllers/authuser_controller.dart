import 'package:get/get.dart';

import '../services/http_service.dart';

class AuthController extends GetxController {
  Future register(String firstName, String lastName, String phone) async {
    final data = {"firstName": firstName, "lastName": lastName, "phone": phone};

    final res = await HttpService().postRequest(
      "${HttpService().url}/api/users/register",
      data,
    );

    return res;
  }
}
