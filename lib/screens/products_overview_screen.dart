// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/cart.dart';
import 'package:shopingwithstmanagement/providers/producs_provider.dart';
import 'package:shopingwithstmanagement/widgets/203%20badge.dart';
import 'package:shopingwithstmanagement/widgets/app_drawer.dart';
import 'package:shopingwithstmanagement/widgets/productsgrid.dart';

enum FilterOptions {
  Favorites,
  All,
}

// ignore: use_key_in_widget_constructors
class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _init = false;
  @override
  void didChangeDependencies() {
    if (_init == false) {
      Provider.of<Products>(context).fetchAndSetproducts();
    }
    _init=true;
    super.didChangeDependencies();
  }

  var _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(
        title: Text('availableItems'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              setState(() {
                if (selectedOption == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorite'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('ShowAll'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cartScreen');
                },
                icon: Icon(
                  Icons.shopping_cart,
                ),
              ),
              value: cart.ItemCount.toString(),
            ),
          ),
        ],
      ),
      drawer: appDrawer(),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
