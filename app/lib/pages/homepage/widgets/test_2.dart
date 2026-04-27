import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:first/controllers/photo_controller.dart';

class Test2 extends StatelessWidget {
  Test2({super.key});
  final controller = Get.put(PhotoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.builder(
            itemCount: controller.photo.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
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
