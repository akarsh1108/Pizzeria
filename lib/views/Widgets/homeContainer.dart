import 'package:flutter/material.dart';

class homeContainer extends StatefulWidget {
  const homeContainer({Key? key}) : super(key: key);

  @override
  _homeContainerState createState() => _homeContainerState();
}

class _homeContainerState extends State<homeContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
                flex: 1,
                child: Image(
                  alignment: Alignment.centerRight,
                  image: AssetImage(
                    "assets/pizza.jpg",
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Non Veg Pizza',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Flexible(
                 child: new Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: Text(
                        'Button 2',
                        style: Theme.of(context).primaryTextTheme.button,
                      ),
                      onPressed: () {},
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
