// ignore_for_file: deprecated_member_use

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
    //Cart Provider is used to store the items in cart when added
    return Consumer<CartProvider>(builder: (context, provider, _) {
      //To stack the shape of image on top of the dialog
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
                boxShadow: const [
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
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text('Select Crust'),
                const SizedBox(height: 10),
                //Initially default crust are selected if customer wants to change he can change
                //The size of the pizza changes with customer response
                bodyContent(widget.crust, widget.defaultCrust),
                const SizedBox(
                  height: 15,
                ),
                const Text('Select Size'),
                const SizedBox(height: 10),
                bodyContent2(widget.crust, widget.defaultCrust),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    children: [
                      FlatButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontSize: 18),
                          )),
                      const Spacer(),
                      FlatButton(
                          onPressed: () {
                            //Making check as the superKey mixing id to avoid thr redundency in the cart page
                            String check = widget.nameid.toString() +
                                '.' +
                                widget.crust[selectCrustIndex - 1].id
                                    .toString() +
                                '.' +
                                widget.crust[selectCrustIndex - 1]
                                    .sizes[selectSizeIndex - 1].id
                                    .toString();
                            Get.back();
                            provider.addProduct(
                                check,
                                widget.title,
                                widget.crust[selectCrustIndex - 1].name,
                                widget.crust[selectCrustIndex - 1]
                                    .sizes[selectSizeIndex - 1].name,
                                widget.crust[selectCrustIndex - 1]
                                    .sizes[selectSizeIndex - 1].price);
                          },
                          child: const Text(
                            'Add To Cart',
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
                      const BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                  child: Image.asset("assets/pizza.jpg")),
            ),
          ),
        ],
      );
    });
  }

  bodyContent(List<Crusts> crust, int defaultCrust) {
    //Initially check if value is -1 then automatically select the defaultCrust
    selectCrustIndex =
        (selectCrustIndex == -1) ? defaultCrust : selectCrustIndex;
        //To avoid pixel overflow when lot of data is present list view is wrapped in a container
    return Container(
        height: (crust.length) * 100,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.20),
            //Sometimes List view is not scrollable in container to avoid that RawScrollBar is used 
            //The scroll is customised , scroll dissapears in inactivity
        child: RawScrollbar(
            isAlwaysShown: false,
            thumbColor: const Color.fromARGB(255, 255, 102, 68).withAlpha(90),
            thickness: 5,
            interactive: true,
            crossAxisMargin: 10,
            radius: const Radius.circular(5),
            //Fetches all crust contents and store in container 
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: crust.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                          selected: selectCrustIndex == crust[index].id
                              ? true
                              : false,
                          selectedTileColor: const Color.fromARGB(255, 255, 119, 119),
                          selectedColor: Colors.white,
                          title: Text(crust[index].name),
                          onTap: () {
                            setState(() {
                              //Change select size Index an everytime value changes select index value changes to -1 
                              selectSizeIndex = -1;
                              selectCrustIndex = crust[index].id;
            
                            });
                          }));
                })));
  }

  bodyContent2(List<Crusts> crust, int defaultCrust) {
       //Initially check if value is -1 then automatically select the defaultCrust
    selectCrustIndex =
        (selectCrustIndex == -1) ? defaultCrust : selectCrustIndex;
        //With selectCrustIndex  the size of pizza's are stored and default size is selected
    selectSizeIndex = (selectSizeIndex == -1)
        ? crust[selectCrustIndex - 1].defaultSize
        : selectSizeIndex;
    List<Sizes> sizes = crust[selectCrustIndex - 1].sizes;
    return Container(
        height: (sizes.length) * 100,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.27),
               //Sometimes List view is not scrollable in container to avoid that RawScrollBar is used 
            //The scroll is customised , scroll dissapears in inactivity
        child: RawScrollbar(
            isAlwaysShown: false,
            thumbColor: const Color.fromARGB(255, 255, 102, 68).withAlpha(90),
            thickness: 5,
            interactive: true,
            crossAxisMargin: 10,
            radius: const Radius.circular(5),
            //Contains list of pizza crust size list 
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: sizes.length,
                itemBuilder: (context, index) {
                  return Card(
                    //If tile is selected then the colour of the container changes
                      child: ListTile(
                          selected:
                              selectSizeIndex == sizes[index].id ? true : false,
                          selectedTileColor: const Color.fromARGB(255, 255, 119, 119),
                          selectedColor: Colors.white,
                          title: Row(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(sizes[index].name)),
                              const Spacer(),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                  //By using this  we can get  indian currency symbol
                                      Text('\u{20B9} ${sizes[index].price}')),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              selectSizeIndex = sizes[index].id;
                            });
                          }));
                })));
  }
}
