import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pizzeria/model/pizzamodel.dart';

class ApiServices {
  final String baseUrl =
      "https://625bbd9d50128c570206e502.mockapi.io/api/v1/pizza/1";

  Future<PizzaModel> pizzaDetails() async {
    var url = Uri.parse('$baseUrl');
    var response = await http.get(url);
    var body = response.body;
    Map<String, dynamic> jsonData = jsonDecode(body);
    PizzaModel decode = PizzaModel.fromJson(jsonData);
    return decode;
  }
}
