import 'package:flutter/material.dart';
import 'package:pizzeria/model/pizzamodel.dart';
import 'package:pizzeria/services/services.dart';

class DetailsProvider with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final ApiServices _apiServices = ApiServices();
  Sizes _sizes = Sizes(id: 1, name: "", price: 10);
  Crusts _crusts = Crusts(id: 1, name: "", defaultSize: 2, sizes: []);
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
}
