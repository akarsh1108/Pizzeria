import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzeria/model/pizzamodel.dart';
import 'package:pizzeria/services/services.dart';

class DetailsProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final ApiServices _apiServices = ApiServices();
  PizzaModel _pizzaModel = PizzaModel(
    id: "",
    crusts: [],
    defaultCrust: 0,
    description: '',
    isVeg: false,
    name: '',
  );
  PizzaModel get PizzaList => _pizzaModel;
  void get() {
    notifyListeners();
  }

  void getNames() async {
    _isLoading = true;
   _pizzaModel = await _apiServices.pizzaDetails();
    _isLoading = false;
    notifyListeners();
  }

  Map<String, int> productCount = {};
  void addProduct(String product) {
    if (productCount.containsKey(product)) {
      productCount.update(product, (value) => ++value);
    } else {
      productCount[product] = 1;
    }
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
