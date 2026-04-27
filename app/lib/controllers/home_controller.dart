import 'package:get/get.dart';
import '../services/http_service.dart';

class HomeController extends GetxController {
  // Data
  var categories = [].obs;
  var featuredProducts = [].obs;
  var buyAgain = [].obs;
  var homeData = [].obs;
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
