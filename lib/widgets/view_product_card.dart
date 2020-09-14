import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/services/base_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ViewProductCard extends StatefulWidget {
  final Product product;
  const ViewProductCard ({ Key key, this.product }): super(key: key);
  @override
  _ViewProductCardState createState() => _ViewProductCardState();
}

class _ViewProductCardState extends State<ViewProductCard> {
  final _formKey = GlobalKey<FormState>();
  int _quantity;
  void addToCart(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    final response = await http.post(
        BaseApiClient.ADD_TO_CART_URL,
        body: jsonEncode(<String, dynamic>{
          'product_id': widget.product.id,
          'quantity': _quantity
        }),
        headers: BaseApiClient.getHeaders(token)
    );
    if (response.statusCode == 200) {
      _showToastSuccess(context);
    } else if(response.statusCode == 401){
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  void _showToastSuccess(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: const Text('Product added to cart successfully!', style: TextStyle(color: Colors.white)),
        action: SnackBarAction(
          label: 'Hide', onPressed: scaffold.hideCurrentSnackBar, textColor: Colors.white,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        widget.product.image_url
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.product.description,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "In stock: " + widget.product.in_stock,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                    "\$" + widget.product.price,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green
                    )
                ),
              ],
            ),
            SizedBox(height: 70,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Quantity',
                    ),
                    validator: (value) {
                      if (value.isEmpty || int.parse(value) <= 0) {
                        return 'Please enter a value bigger than 0';
                      }
                      if(int.parse(value) > int.parse(widget.product.in_stock)){
                        return 'Please enter a value below or equal to ' + widget.product.in_stock;
                      }
                      return null;
                    },
                    onSaved: (String value){
                      _quantity = int.parse(value);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 150,),
            Align(
                alignment: Alignment.bottomLeft,
                child: ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  child: RaisedButton.icon(
                      color: Colors.lightBlue,
                      onPressed: () {
                        if(!_formKey.currentState.validate()){
                          return;
                        }
                        _formKey.currentState.save();
                        addToCart(context);
                      },
                      icon: Icon(Icons.shopping_cart, color: Colors.white,),
                      label: Text("Add to cart", style: TextStyle(color: Colors.white),)
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
