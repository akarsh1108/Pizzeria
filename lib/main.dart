import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pizzeria/constants/theme.dart';
import 'package:pizzeria/provider/cartProvider.dart';
import 'package:pizzeria/provider/detailsProvider.dart';
import 'package:pizzeria/views/cartPage.dart';
import 'package:pizzeria/views/homePage.dart';
import 'package:provider/provider.dart';

import 'constants/appPages.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    //To fix the view as portrait
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
    //Here for state management providers are used to perform all backend works
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
          //Getx is used for navigation betweeen pages
          getPages: [
            //Stores HomePage Navigation
           GetPage(
             name:AppPages.HomePage,
             page:()=> const HomeScreen(),
           ),
           //Stores CartPage Navigation
           GetPage(
             name:AppPages.CartPage,
             page:()=> const CartScreen(),
           )
          ],
      
      ),
    );
  }
  }


