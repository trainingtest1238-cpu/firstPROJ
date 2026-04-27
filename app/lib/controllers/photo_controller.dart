import 'package:first/models/photo.dart';
import 'package:first/services/photo_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  var isLoading = true.obs;
  var photo = <Photo>[].obs;
  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
  }

  void fetchPhotos() async {
    try {
      isLoading.value = true;
      final result = await PhotoService().fetchPhotos();
      photo.assignAll(result);
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
