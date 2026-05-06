import 'package:get/get.dart';
import '../services/http_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var categories = [].obs;
  var featuredProducts = [].obs;
  var buyAgain = [].obs;
  var homeData = [].obs;
  var cartItems = [].obs;
  Future getHomeData() async {
    final data = await HttpService().getRequest(
      "${HttpService().url}/api/products/home",
    );
    print(data);
    homeData.value = data;

    final featured = data.firstWhere(
      (e) => e['sectiontybe'] == 'special',
      orElse: () => null,
    );

    if (featured != null) {
      featuredProducts.value = featured['products'];
      print("featered count = ${featuredProducts.length}");
    }
    final buyAgainSection = data.firstWhere(
      (e) => e['sectiontybe'] == 'buy_again',
      orElse: () => null,
    );
    if (buyAgainSection != null) {
      buyAgain.value = buyAgainSection['products'];
    }
  }

  Future getCategories() async {
    final data = await HttpService().getRequest(
      "${HttpService().url}/api/categories",
    );
    print(data);
    categories.value = data;
  }

  Future AddToCart(Map<String, dynamic> product, int quantity) async {
    final data = await HttpService().postRequest(
      "${HttpService().url}/api/cart/add",
      {"productID": product["productID"], "Quantity": quantity},
    );
    print(data);
  }

  Future getCart() async {
    final data = await HttpService().getRequest(
      "${HttpService().url}/api/cart",
    );

    cartItems.value = data;
    print("cart items =$cartItems");
  }

  Future updateQuantity(int cartItemID, int quantity) async {
    await HttpService().putRequest(
      "${HttpService().url}/api/cart/update/$cartItemID/$quantity",
      {},
    );
    await getCart();
  }

  Future removeItem(int cartItemID) async {
    await HttpService().deleteRequest(
      "${HttpService().url}/api/cart/remove/$cartItemID",
      {},
    );
    await getCart();
  }

  Future clearCart() async {
    await HttpService().deleteRequest(
      "${HttpService().url}/api/cart/clear",
      {},
    );
    cartItems.clear();
  }

  Future checkout() async {
    final data = await HttpService().postRequest(
      "${HttpService().url}/api/cart/checkout",
      {},
    );
    print(data);

    await getCart();
    Get.snackbar("Success", "Order placed successfully");
  }

  @override
  void onInit() {
    getHomeData();
    getCategories();
    super.onInit();
  }

  var selectedIndex = 2.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void onCategoryClick(String title) {
    print("Clicked $title");
  }

  void onSpecialClick(String title) {
    print(title);
  }

  void onBuyAgainClick(String name) {
    print(name);
  }
}
