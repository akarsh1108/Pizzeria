import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void get() {
    notifyListeners();
  }

  int _totalAmount = 0;
  int get TotalAmount => _totalAmount;
  int _totalProduct = 0;
  int get TotalProduct => _totalProduct;
  Map<String, int> productCount = {};
  Map<String, int> get ProductCount => productCount;
  List<String> _productidName = [];
  List<String> get ProductidName => _productidName;
  List<String> _titleNames = [];
  List<String> get TitleNames => _titleNames;
  List<String> _crustName = [];
  List<String> get crustName => _crustName;
  List<String> _sizeName = [];
  List<String> get sizeName => _sizeName;
  List<int> _pizzaPrice = [];
  List<int> get PizzaPrice => _pizzaPrice;
  void addProduct(String product, String title, String crustname,
      String sizename, int price) {
    int cartSize = _productidName.length;
    if (_productidName.contains(product)) {
      productCount.update(product, (value) => ++value);
    } else {
      productCount[product] = 1;
      _productidName.insert(cartSize, product);
      _titleNames.insert(cartSize, title);
      _crustName.insert(cartSize, crustname);
      _sizeName.insert(cartSize, sizename);
      _pizzaPrice.insert(cartSize, price);
    }
    addtotal(price);
    Get.snackbar("Product Added Successfully", "You have added your pizza",
        snackPosition: SnackPosition.TOP, duration: Duration(seconds: 1));

    notifyListeners();
  }

  void decrementProduct(String product, int price) {
    if (productCount[product]! > 1) {
      productCount.update(product, (value) => --value);
    } else {
      productCount[product] = 0;
      final index = _productidName.indexWhere((element) => element == product);
      _productidName.removeAt(index);
      _titleNames.removeAt(index);
      _crustName.removeAt(index);
      _sizeName.removeAt(index);
      _pizzaPrice.removeAt(index);
    }
    decTotal(price);
    notifyListeners();
  }

  void addtotal(int price) {
    _totalProduct++;
    _totalAmount = _totalAmount + price;
    notifyListeners();
  }

  void decTotal(int price) {
    _totalProduct--;
    _totalAmount = _totalAmount - price;
    notifyListeners();
  }

  void addItem(String nameid, int price) {
    productCount.update(nameid, (value) => ++value);
    addtotal(price);
    notifyListeners();
  }

  void clearAll() {
    _productidName.clear();
    _titleNames.clear();
    _crustName.clear();
    _sizeName.clear();
    _pizzaPrice.clear();
    (_totalProduct != 0)
        ? Get.snackbar(
            "Purchase Successful", "Bill Amount \u{20B9} ${_totalAmount}",
            snackPosition: SnackPosition.TOP, duration: Duration(seconds: 1))
        : Get.snackbar("Cart is empty", "Add pizza to cart ",
            snackPosition: SnackPosition.TOP, duration: Duration(seconds: 1));
    productCount = {};
    _totalAmount = 0;
    _totalProduct = 0;
    notifyListeners();
  }
}
