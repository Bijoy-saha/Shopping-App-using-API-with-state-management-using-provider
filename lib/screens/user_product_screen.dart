import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/producs_provider.dart';
import 'package:shopingwithstmanagement/screens/edit_product_screen.dart';
import 'package:shopingwithstmanagement/widgets/app_drawer.dart';
import 'package:shopingwithstmanagement/widgets/user_products.dart';

// ignore: use_key_in_widget_constructors
class UserProductScreen extends StatelessWidget {
  static const routeName = '/useritem';
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'your own products',
          style: GoogleFonts.lato(
            // ignore: prefer_const_constructors
            textStyle: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: 'null');
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: appDrawer(),
      body: ListView.builder(
        itemBuilder: (_, i) => Column(
          children: [
            UserProductItem(
                id: userData.items[i].id,
                title: userData.items[i].title,
                imageUrl: userData.items[i].imageUrl),
            Divider(),
          ],
        ),
        itemCount: userData.items.length,
      ),
    );
  }
}
