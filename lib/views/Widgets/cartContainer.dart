import 'package:flutter/material.dart';
import 'package:pizzeria/provider/cartProvider.dart';
import 'package:provider/provider.dart';

class cartContainer extends StatefulWidget {
  const cartContainer({
    required this.title,
    required this.crust,
    required this.size,
    required this.count,
    required this.nameid,
    required this.cost,
    required this.provider,
  });
  final String title;
  final String crust;
  final String size;
  final String nameid;
  final int? count;
  final int cost;
  final CartProvider provider;
  @override
  _cartContainerState createState() => _cartContainerState();
}

class _cartContainerState extends State<cartContainer> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 140,
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFDB3224)),
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  children: <Widget>[
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
                          Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                    text: '${widget.title}',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline6!
                                        .copyWith(fontSize: 20),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\u{20B9} ${widget.cost}",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline6,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("${widget.crust}",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2),
                              Spacer(),
                              Text("${widget.size}",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Count",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: Color(0xFFDB3224),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                              SizedBox(width: 20),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFFDB3224)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFDB3224)),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.all(5.0),
                                        constraints: BoxConstraints(),
                                        icon: const Icon(
                                          Icons.remove,
                                        ),
                                        tooltip: 'Remove one item ',
                                        onPressed: () {
                                          widget.provider.decrementProduct(
                                              widget.nameid, widget.cost);
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFDB3224)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("${widget.count}",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .subtitle2),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFDB3224)),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.all(5.0),
                                        constraints: BoxConstraints(),
                                        icon: const Icon(Icons.add),
                                        tooltip: 'Add one item ',
                                        onPressed: () {
                                          widget.provider.addItem(
                                              widget.nameid, widget.cost);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]))
                  ],
                ))),
      ),
    );
  }
}
