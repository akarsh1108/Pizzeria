// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  bool hasInternet = false;
  @override
  void initState() {
    //Check if internet is working as the data are fetch through api
    checkInternetConnection();
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
      //Consumer is used to interact with models and widget
      body: Consumer<DetailsProvider>(builder: (context, provider, _) {
        PizzaModel _apiModel = provider.PizzaList;
        //Circular Loading shows until the api is getting fetched
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(12.0),
          //All pizza details are stored in vertical scroll 
          child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                //Api model is passed through the container to access all _data
                //To avoid repeatations Home container has a seperate class
                return homeContainer(apiModel: _apiModel);
              }),
        );
      }),
      //Navigate to cart page .
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

//Flutter connection_checker_package was used to check internet
  void checkInternetConnection() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      _showDialog(context);
    }
  }
}

//If internet is not available a dialog box pop up
void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("No Internet Connection"),
            actions: <Widget>[
               FlatButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Close"))
            ]);
      });
}
