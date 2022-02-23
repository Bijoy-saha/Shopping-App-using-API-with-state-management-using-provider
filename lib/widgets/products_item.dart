// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/models/product.dart';
import 'package:shopingwithstmanagement/providers/cart.dart';

// ignore: use_key_in_widget_constructors
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (ctx) => ProductDetailScreen(title),
            //   ),
            // );
            Navigator.of(context).pushNamed(
              '/detailsScreen',
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: Consumer<Product>(
            builder: (context, Product, child) => IconButton(
              color: Colors.red,
              padding: EdgeInsets.all(5),
              onPressed: () {
                product.toggleFavorites();
              },
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
          ),
          trailing: IconButton(
            padding: EdgeInsets.all(5),
            onPressed: () {

              cart.addIteam(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              
             
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text(
                    'Added to the Cart',
                    textAlign: TextAlign.center,
                  ),
                  action: SnackBarAction(
                    onPressed: (){
                      cart.removeSingleItem(product.id);
                    },
                    label: 'UNDO',
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
            color: Colors.orange,
          ),
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
