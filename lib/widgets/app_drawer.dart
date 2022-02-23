import 'package:flutter/material.dart';
import 'package:shopingwithstmanagement/screens/user_product_screen.dart';

class appDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: Text('hello man!'),
            height: 100,
            color: Colors.teal,
            width: double.infinity,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/orderscreen');
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('UserProducts'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
