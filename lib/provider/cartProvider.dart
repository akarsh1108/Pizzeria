import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void get() {
    notifyListeners();
  }

  Map<String, int> productCount = {};
  void addProduct(String product) {
    if (productCount.containsKey(product)) {
      productCount.update(product, (value) => ++value);
    } else {
      productCount[product] = 1;
    }
    print(
        'heeeeeeeeeeeeeeeeelllllllllllllllllllllllooooooooo ${productCount[product]}');
    Get.snackbar("Product Added Successfully", "You have added your pizza",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }

  void decreementProduct(String product) {
    if (productCount.containsKey(product)) {
      productCount.update(product, (value) => --value);
    } else {
      productCount[product] = 1;
    }
    Get.snackbar("Product Removed Successfully", "You have Removed your pizza",
        snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 2));
  }
}
