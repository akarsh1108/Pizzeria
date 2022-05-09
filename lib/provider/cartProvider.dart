import 'package:flutter/material.dart';
import 'package:get/get.dart';

//In this page all the calculation part of cart page is available here
class CartProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void get() {
    notifyListeners();
  }

//Storing initial value of totalAmount
  int _totalAmount = 0;
  int get TotalAmount => _totalAmount;
  //Strong initial count of the cart
  int _totalProduct = 0;
  int get TotalProduct => _totalProduct;
  //Mapping the count of datas through passed super key ProductidName
  Map<String, int> productCount = {};
  Map<String, int> get ProductCount => productCount;
  //Stroring product id and binding all list together
  List<String> _productidName = [];
  List<String> get ProductidName => _productidName;
  //Storing title name of the pizza
  List<String> _titleNames = [];
  List<String> get TitleNames => _titleNames;
  //Storing crust name of the pizza
  List<String> _crustName = [];
  List<String> get crustName => _crustName;
  //Storing the size of the pizza
  List<String> _sizeName = [];
  List<String> get sizeName => _sizeName;
  //Storing price of the pizza
  List<int> _pizzaPrice = [];
  List<int> get PizzaPrice => _pizzaPrice;

  //Incrementing and adding pizza in cart
  void addProduct(String product, String title, String crustname,
      String sizename, int price) {
    int cartSize = _productidName.length;
    //Check if pizza id is present in productidname if present value of product count increases
    if (_productidName.contains(product)) {
      productCount.update(product, (value) => ++value);
    } else {
      //If pizza id is not present the id is stored in map and all the list by this index number is mantained and all details can be easily accessed
      productCount[product] = 1;
      _productidName.insert(cartSize, product);
      _titleNames.insert(cartSize, title);
      _crustName.insert(cartSize, crustname);
      _sizeName.insert(cartSize, sizename);
      _pizzaPrice.insert(cartSize, price);
    }
    //Used to increment thr total value of the product
    addtotal(price);
    //It inform users in form of snackbar that selected item has been added
    Get.snackbar("Product Added Successfully", "You have added your pizza",
        snackPosition: SnackPosition.TOP, duration: Duration(seconds: 1));
    //Call the provider again and update the value
    notifyListeners();
  }

//To delete pizza from the cart
  void decrementProduct(String product, int price) {
    if (productCount[product]! > 1) {
      //If value is greater then one the product count decreases by one
      productCount.update(product, (value) => --value);
    } else {
      //If value is one after decrementing value becomes zero so there is no use of that item
      //So using the index all infomation of that productid is removed from the cart until it is again added to the cart
      productCount[product] = 0;
      final index = _productidName.indexWhere((element) => element == product);
      _productidName.removeAt(index);
      _titleNames.removeAt(index);
      _crustName.removeAt(index);
      _sizeName.removeAt(index);
      _pizzaPrice.removeAt(index);
    }
    //Decrement the total price and amount
    decTotal(price);
    notifyListeners();
  }

//Add an item and change the value of totalproduct and amount
  void addtotal(int price) {
    _totalProduct++;
    _totalAmount = _totalAmount + price;
    notifyListeners();
  }

  //Remove an item and change the value of totalproduct and amount
  void decTotal(int price) {
    _totalProduct--;
    _totalAmount = _totalAmount - price;
    notifyListeners();
  }

//This is used to increase the amount without giving snackbar
  void addItem(String nameid, int price) {
    productCount.update(nameid, (value) => ++value);
    addtotal(price);
    notifyListeners();
  }

  //After all items are bought the cart is emptied
  void clearAll() {
    _productidName.clear();
    _titleNames.clear();
    _crustName.clear();
    _sizeName.clear();
    _pizzaPrice.clear();
    //After buying the cart show snackbar if cart is empty and customer click cart he would be redirecte with comment cart is empty
    //Else the total amount eith purchase successfull would be shown
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
