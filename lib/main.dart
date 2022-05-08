import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizzeria/constants/theme.dart';
import 'package:pizzeria/provider/cartProvider.dart';
import 'package:pizzeria/provider/detailsProvider.dart';
import 'package:pizzeria/views/cartPage.dart';
import 'package:pizzeria/views/homePage.dart';
import 'package:provider/provider.dart';

import 'constants/appPages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
         ChangeNotifierProvider(
          create: (_) => DetailsProvider(),
        ),
         ChangeNotifierProvider(
          create: (_) => CartProvider(),
        )
      ],
      child: GetMaterialApp(
          title: 'Pizzeria',
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.HomePage,
          theme: ThemeClass.buildTheme(context),
          getPages: [
           GetPage(
             name:AppPages.HomePage,
             page:()=> const HomeScreen(),
           ),
           GetPage(
             name:AppPages.HomePage,
             page:()=> const CartScreen(),
           )
          ],
      
      ),
    );
  }
  }


