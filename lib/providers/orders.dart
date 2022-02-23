import 'package:flutter/cupertino.dart';
import 'package:shopingwithstmanagement/providers/cart.dart';
// ignore: unused_import
import 'package:shopingwithstmanagement/widgets/cartItem.dart';

class OrderItem {
  final String id;
  final String amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void AddOrder(List<CartItem> orderlist, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total.toString(),
          products: orderlist,
          dateTime: DateTime.now()),
    );
    notifyListeners();
  }
}
