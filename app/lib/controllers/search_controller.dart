import 'package:first/services/http_service.dart';
import 'package:get/get.dart';
// import '../models/item.dart';
// import '../data/items_data.dart';

class SearchXController extends GetxController {
  var selectedCategory = RxnString();
  var recentSearches = <String>[].obs;

  final List<String> categories = [
    'الكروكاسون والمافن والكاندي',
    'الكيك',
    'كعك',
    'الكل',
  ];

  final List<String> trending = [
    'دونات',
    'المناقيش اللبنانية والبيتزا',
    'فطير مشلتت',
    'المعجنات الصغيرة',
  ];
  Future searchProducts(String query) async {
    final data = await HttpService().getRequest(
      "http://192.168.0.133:8060/api/products/search?query=$query",
    );
    results.value = data;
  }

  var results = [].obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
    if (!recentSearches.contains(category)) {
      recentSearches.insert(0, category);
    }
  }
}
