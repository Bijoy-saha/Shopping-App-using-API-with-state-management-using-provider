import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/providers/orders.dart';
import 'package:shopingwithstmanagement/widgets/app_drawer.dart';
import 'package:shopingwithstmanagement/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName='/orderscreen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderedItem = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: appDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItems(order: orderedItem.orders[i]),
        itemCount: orderedItem.orders.length,
      ),
    );
  }
}
