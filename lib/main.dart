import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/cart.dart';
import 'package:shopingwithstmanagement/providers/orders.dart';
import 'package:shopingwithstmanagement/providers/producs_provider.dart';
import 'package:shopingwithstmanagement/screens/cartscreen.dart';
import 'package:shopingwithstmanagement/screens/edit_product_screen.dart';
import 'package:shopingwithstmanagement/screens/order_screen.dart';
import 'package:shopingwithstmanagement/screens/products_detils_screen.dart';
import 'package:shopingwithstmanagement/screens/products_overview_screen.dart';
import 'package:shopingwithstmanagement/screens/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.teal,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen(),
          UserProductScreen.routeName: (context) => UserProductScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
