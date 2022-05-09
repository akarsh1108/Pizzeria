import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzeria/constants/appPages.dart';
import 'package:pizzeria/model/pizzamodel.dart';
import 'package:pizzeria/provider/detailsProvider.dart';
import 'package:pizzeria/views/Widgets/homeContainer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  void initState() {
    super.initState();
    Provider.of<DetailsProvider>(context, listen: false).getNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizzeria',
            style: Theme.of(context).primaryTextTheme.headline3),
      ),
      body: Consumer<DetailsProvider>(builder: (context, provider, _) {
        PizzaModel _apiModel = provider.PizzaList;
        if (provider.isLoading) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return homeContainer(apiModel: _apiModel);
              }),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppPages.CartPage);
        },
        label:
            Text('View Cart', style: Theme.of(context).primaryTextTheme.button),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
