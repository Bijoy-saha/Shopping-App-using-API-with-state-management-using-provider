import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/producs_provider.dart';
import 'package:shopingwithstmanagement/widgets/products_item.dart';

class ProductsGrid extends StatelessWidget {
  var _showFav;
  ProductsGrid(this._showFav);

  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context, listen: false);
    final products = _showFav ? productsdata.FavoritesOnly : productsdata.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        // ignore: prefer_const_constructors
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(),
            )
        // (
        //   create: (e)=>products[i],
        //   child: ProductItem(
        //     // products[i].id,
        //     // products[i].title,
        //     // products[i].imageUrl,
        //   ),
        // ),
        );
  }
}
