import 'package:flutter/material.dart';
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
  var apiModel;

  @override
   void initState() {
    super.initState();
    Provider.of<DetailsProvider>(context, listen: false).getNames();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizzeria'),
        ),
        body: Consumer<DetailsProvider>(
        builder: (context, provider, _) {
        PizzaModel _apiModel = provider.PizzaList;
          print(_apiModel.name);
          if (provider.isLoading) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          print(_apiModel);
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount:1,
              itemBuilder: (BuildContext context, int index) {
                return homeContainer( apiModel: _apiModel);
              }),
          );
            })
    );
  }
}
