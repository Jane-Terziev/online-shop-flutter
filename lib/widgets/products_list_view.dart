import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/services/base_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:online_shop/widgets/product_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProductsListView extends StatefulWidget {
  final String category_id;
  const ProductsListView ({ Key key, this.category_id }): super(key: key);

  @override
  _ProductsListViewState createState() => _ProductsListViewState();
}

class _ProductsListViewState extends State<ProductsListView> {
  List<Product> data;
  bool _progressController = true;

  Future<List<Product>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    final response = await http.get(BaseApiClient.getProductByCategoryURL(widget.category_id), headers: BaseApiClient.getHeaders(token));
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
    if(data != null && data.isEmpty) {
      return Center(
        child: Text("Category has no products.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      );
    }
    return _progressController
        ? Center(child: SpinKitRotatingPlain(color: Colors.lightBlue, size: 100,))
        : ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          print(data[index]);
          return ProductCard(product: data[index]);
        }
    );
  }
}
