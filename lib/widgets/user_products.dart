import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/producs_provider.dart';
import 'package:shopingwithstmanagement/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  UserProductItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Provider.of<Products>(context,listen: false).deleteproduct(id);
              },
              icon: Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                print(id);
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
