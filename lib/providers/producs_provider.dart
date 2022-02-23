import 'package:flutter/widgets.dart';
import 'package:shopingwithstmanagement/models/product.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBf0ieUjzJ8T2mCDAg2ue8KIA1KQmnMFLyzw&usqp=CAU',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/assets/images/11451832/2020/2/17/ab1f2c29-7e34-47ca-a076-86bc3d0c74b91581932639895-Puma-Men-Track-Pants-1611581932636565-1.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://www.kristaelsta.com/wp-content/uploads/2020/04/100-cashmere-mustard-yellow-scarf-travel-wrap-schal-04.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy1lnmbIUjNDEgCS2yZSbuatq3zB2lUX5yZYCaq04zguza9WRcKo0ag82DuJ3uE_jGTxA&usqp=CAU',
    // ),
  ];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get FavoritesOnly {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> fetchAndSetproducts() async {
    var url = Uri.parse(
        'https://shopping-app-436d9-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      print(response);
      print(json.decode(response.body));
      final loadeddata = json.decode(response.body) as Map<String, dynamic>;
      // ignore: unused_local_variable
      final List<Product> loadedProducts = [];
      loadeddata.forEach((prodid, proddata) {
        loadedProducts.add(Product(
          id: prodid,
          description: proddata['description'],
          imageUrl: proddata['imageUrl'],
          price: proddata['price'],
          title: proddata['title'],
          isFavorite: proddata['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    var url = Uri.parse(
        'https://shopping-app-436d9-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }),
      );
      final newproduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newproduct);
      // _items.insert(0, newproduct);
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteproduct(String id) {
    final url = Uri.parse(
        'https://shopping-app-436d9-default-rtdb.firebaseio.com/products/$id.json');
    http.delete(url);
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
