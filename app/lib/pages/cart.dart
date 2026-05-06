import 'package:first/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatelessWidget {
  Cart({super.key});
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cart"),
        actions: [
          IconButton(
            onPressed: () {
              controller.clearCart();
            },
            icon: Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text('cart is empty !'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  final cartItemID = item['cartItemID'];
                  final quantity = item['quantity'] ?? 0;
                  print(item);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/assets/images/${item['productImage']}",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "product #${item['productID']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Qty : ${item['quantity']}"),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Text("${item['productPrice']} JD"),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (quantity <= 1) {
                                      controller.removeItem(cartItemID);
                                    } else {
                                      controller.updateQuantity(
                                        cartItemID,
                                        quantity - 1,
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Text("$quantity"),

                                IconButton(
                                  onPressed: () {
                                    controller.updateQuantity(
                                      cartItemID,
                                      quantity + 1,
                                    );
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                controller.removeItem(cartItemID);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.checkout();
                },
                child: Text("Checkout"),
              ),
            ),
          ],
        );
      }),
    );
  }
}
