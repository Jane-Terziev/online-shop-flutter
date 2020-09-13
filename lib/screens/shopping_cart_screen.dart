import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/services/base_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Product> data;
  bool _progressController = true;

  Future<List<Product>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    final response = await http.get(BaseApiClient.CATEGORY_URL, headers: BaseApiClient.getHeaders(token));
    if (response.statusCode == 200) {
      Map jsonResponse = json.decode(response.body);
      List items = jsonResponse['items'];
      return items.map((product) => new Product.fromJson(product)).toList();
    } else {
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
        _progressController = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Shopping Cart is empty.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    );
  }
}
