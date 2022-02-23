import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopingwithstmanagement/providers/orders.dart';

class OrderItems extends StatefulWidget {
  final OrderItem order;
  OrderItems({
    required this.order,
  });

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              // ignore: prefer_const_constructors
              icon: Icon(Icons.expand_more),
            ),
          ),
          if (_expanded == false)
            Container(
              
              height: min(widget.order.products.length * 20.0 + 100, 180),
              child: ListView(

                children: widget.order.products
                    .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(e.title),
                            Text('${e.quantity}x \$${e.price}')
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
