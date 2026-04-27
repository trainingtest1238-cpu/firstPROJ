import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/controllers/photo_controller.dart';

class Test extends StatelessWidget {
  Test({super.key});
  final controller = Get.put(PhotoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: controller.photo.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Image.network(
                      controller.photo[index].download_url,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(controller.photo[index].author),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
