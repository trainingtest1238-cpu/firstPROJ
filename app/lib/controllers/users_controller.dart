import 'package:first/db_healper.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  final DBHealper db = DBHealper();

  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    isLoading.value = true;
    final data = await db.getAllUsers();
    users.value = data;
    isLoading.value = false;
  }

  Future<void> deleteUser(int id) async {
    await db.deleteUser(id);

    users.removeWhere((user) => user['id'] == id);

    Get.snackbar('Success', 'User deleted');
  }
}
