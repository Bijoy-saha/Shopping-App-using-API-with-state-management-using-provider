import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  // ignore: prefer_collection_literals, unnecessary_new
  Map<String, CartItem> _items = new Map<String, CartItem>();
  Map<String, CartItem> get items {
    return {..._items};
  }

  void removeSingleItem(String productid) {
    if (!_items.containsKey(productid)) {
      return;
    }
    if (_items[productid]!.quantity > 1) {
      _items.update(
        productid,
        (existingItemm) => CartItem(
            id: existingItemm.id,
            price: existingItemm.price,
            quantity: existingItemm.quantity - 1,
            title: existingItemm.title),
      );
    }else{
      _items.remove(productid);
    }
  }

  int get ItemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += (cartItem.price * cartItem.quantity);
    });
    return total;
  }

  void addIteam(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existinItem) => CartItem(
          id: existinItem.id,
          title: existinItem.title,
          price: existinItem.price,
          quantity: existinItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
