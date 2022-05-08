import 'package:flutter/material.dart';
import 'package:pizzeria/model/pizzamodel.dart';
import 'package:pizzeria/views/Widgets/dialogBox.dart';

class homeContainer extends StatelessWidget {
  const homeContainer({Key? key, required this.apiModel}) : super(key: key);
  final PizzaModel apiModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFDB3224)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: Image(
                  alignment: Alignment.centerRight,
                  image: AssetImage(
                    "assets/pizza.jpg",
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: '${apiModel.name}',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Flexible(child: new Text("${apiModel.description}")),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: Text(
                        'ADD',
                        style: Theme.of(context).primaryTextTheme.button,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "${apiModel.name}",
                                crust: apiModel.crusts,
                                defaultCrust: apiModel.defaultCrust,
                                nameid: "${apiModel.id}",
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFEA4235),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
