import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/producs_provider.dart';
import 'package:shopingwithstmanagement/widgets/app_drawer.dart';

// ignore: use_key_in_widget_constructors
class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/detailsScreen';
  // final String title;
  // ProductDetailScreen(this.title);
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).items.firstWhere((prod) => prod.id == productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          loadedProduct.title,
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        
      ),
      drawer: appDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 10),
            Text('\$${loadedProduct.price}',
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 10),
            Text(
              loadedProduct.description,
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
