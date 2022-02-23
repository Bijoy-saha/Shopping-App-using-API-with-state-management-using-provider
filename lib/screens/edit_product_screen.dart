// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopingwithstmanagement/models/product.dart';
import 'package:shopingwithstmanagement/providers/producs_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/editproduct';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var pricefocusnode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final url = TextEditingController();
  // ignore: prefer_final_fields
  var _editproduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  @override
  void dispose() {
    pricefocusnode.dispose();

    super.dispose();
  }

  var _isinit = true;
  var isloading = false;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void didChangeDependencies() {
    if (_isinit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != 'null') {
        _editproduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {

          'title': _editproduct.title,
          'description': _editproduct.description,
          'price': _editproduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editproduct.imageUrl;
      }
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    var check = _form.currentState!.validate();
    if (!check) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      isloading = true;
    });
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    if (productId != 'null') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editproduct.id, _editproduct);
      setState(() {
        isloading = false;
      });
      Navigator.of(context).pop();
    } else {
      try {
         await Provider.of<Products>(context, listen: false).addProduct(_editproduct);
      } catch (error) {
        await showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('error occoured!'),
            content: Text('something is wrong!'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('okay'),
              )
            ],
          ),
        );
      } finally {
        setState(() {
          isloading = false;
        });
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValues['title'],
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please give value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Title'),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(pricefocusnode);
                      },
                      onSaved: (value) {
                        _editproduct = Product(
                            id: _editproduct.id,
                            isFavorite: _editproduct.isFavorite,
                            title: value.toString(),
                            description: _editproduct.description,
                            price: _editproduct.price,
                            imageUrl: _editproduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please give value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Price'),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: pricefocusnode,
                      onSaved: (value) {
                        _editproduct = Product(
                            id: _editproduct.id,
                            isFavorite: _editproduct.isFavorite,
                            title: _editproduct.title,
                            description: _editproduct.description,
                            price: double.parse(value!),
                            imageUrl: _editproduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please give value';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text('Description'),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _editproduct = Product(
                            id: _editproduct.id,
                            isFavorite: _editproduct.isFavorite,
                            title: _editproduct.title,
                            description: value.toString(),
                            price: _editproduct.price,
                            imageUrl: _editproduct.imageUrl);
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                          ),
                          child: url.text.isEmpty
                              ? Text('Enter a Url')
                              : FittedBox(
                                  child: Image.network(url.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'please give value';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.url,
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                            ),
                            onSaved: (value) {
                              _editproduct = Product(
                                id: _editproduct.id,
                                isFavorite: _editproduct.isFavorite,
                                title: _editproduct.title,
                                description: _editproduct.description,
                                price: _editproduct.price,
                                imageUrl: value.toString(),
                              );
                            },
                            controller: _imageUrlController,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
