import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:online_shop/models/cart.dart';
import 'package:online_shop/services/base_api_client.dart';
import 'package:online_shop/widgets/shopping_cart_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShoppingCartListView extends StatefulWidget {
  @override
  _ShoppingCartListViewState createState() => _ShoppingCartListViewState();
}

class _ShoppingCartListViewState extends State<ShoppingCartListView> {
  Cart data;

  Future<Cart> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    final response = await http.get(BaseApiClient.GET_SHOPPING_CART, headers: BaseApiClient.getHeaders(token));
    if (response.statusCode == 200) {
      Map jsonResponse = json.decode(response.body);
      return Cart.fromJson(jsonResponse);
    } else if(response.statusCode == 401){
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void initState(){
    super.initState();
    this.getData().then((value) {
      if (!mounted) return;
      setState(() {
        data = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    if(data == null){
      return Center(child: SpinKitRotatingPlain(color: Colors.lightBlue, size: 100,));
    }
    if(data.order_items.isEmpty){
      return Center(
        child: Text("Shopping cart is empty.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      );
    }
    return ListView.builder(
        itemCount: data.order_items.length,
        itemBuilder: (context, index) {
          return ShoppingCartCard(order_item: data.order_items[index]);
        }
    );
  }
}
