// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/cart.dart';
import 'package:shopingwithstmanagement/providers/orders.dart';
import 'package:shopingwithstmanagement/screens/order_screen.dart';
import 'package:shopingwithstmanagement/widgets/cartItem.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Chip(
                    label: Text(
                      cart.totalAmount.toString(),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<Order>(context, listen: false).AddOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                      Navigator.of(context).pushNamed(OrderScreen.routeName);
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartItems(
              id: cart.items.values.toList()[i].id,
              productId: cart.items.keys.toList()[i],
              title: cart.items.values.toList()[i].title,
              quantity: cart.items.values.toList()[i].quantity,
              price: cart.items.values.toList()[i].price,
            ),
            itemCount: cart.items.length,
          ))
        ],
      ),
    );
  }
}
