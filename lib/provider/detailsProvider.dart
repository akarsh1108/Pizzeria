import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzeria/model/pizzamodel.dart';
import 'package:pizzeria/services/services.dart';

class DetailsProvider with ChangeNotifier {
  // is loading is used to manage the circularproggess by the time api is being fetched
  bool _isLoading = true;
  bool get isLoading => _isLoading;

//Created object of the service class
  final ApiServices _apiServices = ApiServices();
  //To avoid null safety default values are stored here
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

//the api is fetched and stored in _pizzaModel
  void getNames() async {
    _isLoading = true;
   _pizzaModel = await _apiServices.pizzaDetails();
    _isLoading = false;
    notifyListeners();
  }


}
