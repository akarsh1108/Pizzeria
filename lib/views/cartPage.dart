import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzeria/provider/cartProvider.dart';
import 'package:pizzeria/views/Widgets/cartContainer.dart';
import 'package:pizzeria/views/homePage.dart';
import 'package:provider/provider.dart';

import '../constants/appPages.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _fromCartPageScroller = ScrollController(initialScrollOffset: 0.0);
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).get();
  }

//Disposing the Scroll option
  @override
  void dispose() {
    super.dispose();
    _fromCartPageScroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
            title: Text('Cart',
                style: Theme.of(context).primaryTextTheme.headline3)),
        body: Column(
          children: [
            //Container to store total count of items and total amount
            PaymentInfoWidget(
              totalAmount: provider.TotalAmount,
              totalProduct: provider.TotalProduct,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: (provider.ProductidName.length) * 200,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.57),
                child: RawScrollbar(
                  isAlwaysShown: false,
                  thumbColor: Color.fromARGB(255, 255, 102, 68).withAlpha(90),
                  thickness: 5,
                  interactive: true,
                  crossAxisMargin: 10,
                  radius: Radius.circular(5),
                  controller: _fromCartPageScroller,
                  //Store all add to cart items one by one
                  child: ListView.builder(
                    itemCount: provider.ProductidName.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Sending the details to display the pizza information and working with them
                      return cartContainer(
                        count: provider
                            .productCount['${provider.ProductidName[index]}'],
                        nameid: provider.ProductidName[index],
                        crust: provider.crustName[index],
                        size: provider.sizeName[index],
                        title: provider.TitleNames[index],
                        cost: provider.PizzaPrice[index],
                        provider: provider,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //After buying the cart is emptied
            provider.clearAll();
            Get.offAll(HomeScreen());
          },
          label: Text('       Buy Now         ',
              style: Theme.of(context).primaryTextTheme.button),
          icon: const Icon(Icons.shopping_cart),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}

//Total ammount and cart count is stored here
class PaymentInfoWidget extends StatelessWidget {
  PaymentInfoWidget({required this.totalProduct, required this.totalAmount});
  int totalProduct;
  int totalAmount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFDB3224),
            width: 3,
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Your Cart',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline6!
                            .copyWith(fontSize: 20)),
                    Spacer(),
                    Text('Item Count: ${totalProduct}',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline6!
                            .copyWith(fontSize: 20))
                  ],
                ),
                SizedBox(height: 30),
                Text('Total Amount : \u{20B9}${totalAmount}',
                    style: Theme.of(context).primaryTextTheme.headline4)
              ]),
        ),
      ),
    );
  }
}
