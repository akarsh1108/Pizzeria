import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzeria/model/pizzamodel.dart';
import 'package:pizzeria/provider/cartProvider.dart';
import 'package:provider/provider.dart';

import '../../constants/dialogconstants.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({
    required this.title,
    required this.crust,
    required this.defaultCrust,
    required this.nameid,
  });
  final String title;
  final List<Crusts> crust;
  final int defaultCrust;
  final String nameid;
  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  int selectCrustIndex = -1;
  int selectSizeIndex = -1;

  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).get();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Consumer<CartProvider>(builder: (context, provider, _) {
      return Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                left: Constants.padding,
                top: Constants.avatarRadius + Constants.padding,
                right: Constants.padding,
                bottom: Constants.padding),
            margin: const EdgeInsets.only(top: Constants.avatarRadius),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(Constants.padding),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Select Crust'),
                SizedBox(height: 10),
                bodyContent(widget.crust, widget.defaultCrust),
                SizedBox(
                  height: 15,
                ),
                Text('Select Size'),
                SizedBox(height: 10),
                bodyContent2(widget.crust, widget.defaultCrust),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      FlatButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(fontSize: 18),
                          )),
                      Spacer(),
                      FlatButton(
                          onPressed: () {
                            String check = widget.nameid.toString() +
                                '.' +
                                widget.crust[selectCrustIndex - 1].id
                                    .toString() +
                                '.' +
                                widget.crust[selectCrustIndex - 1]
                                    .sizes[selectSizeIndex - 1].id
                                    .toString();
                            Get.back();
                            provider.addProduct(check);
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Constants.padding,
            right: Constants.padding,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                  child: Image.asset("assets/pizza.jpg")),
            ),
          ),
        ],
      );
    });
  }

  bodyContent(List<Crusts> crust, int defaultCrust) {
    selectCrustIndex =
        (selectCrustIndex == -1) ? defaultCrust : selectCrustIndex;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: crust.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  selected: selectCrustIndex == crust[index].id ? true : false,
                  selectedTileColor: Color.fromARGB(255, 255, 119, 119),
                  selectedColor: Colors.white,
                  title: Text(crust[index].name),
                  onTap: () {
                    setState(() {
                      selectSizeIndex = -1;
                      selectCrustIndex = crust[index].id;
                      print(selectCrustIndex);
                    });
                  }));
        });
  }

  bodyContent2(List<Crusts> crust, int defaultCrust) {
    selectCrustIndex =
        (selectCrustIndex == -1) ? defaultCrust : selectCrustIndex;
    selectSizeIndex = (selectSizeIndex == -1)
        ? crust[selectCrustIndex - 1].defaultSize
        : selectSizeIndex;
    List<Sizes> sizes = crust[selectCrustIndex - 1].sizes;
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: sizes.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
                  selected: selectSizeIndex == sizes[index].id ? true : false,
                  selectedTileColor: Color.fromARGB(255, 255, 119, 119),
                  selectedColor: Colors.white,
                  title: Row(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(sizes[index].name)),
                      Spacer(),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text('\u{20B9} ${sizes[index].price}')),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      selectSizeIndex = sizes[index].id;
                      print(selectSizeIndex);
                    });
                  }));
        });
  }
}
