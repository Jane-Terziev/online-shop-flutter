import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meet_network_image/meet_network_image.dart';
import 'package:online_shop/models/order_item.dart';
import 'package:online_shop/screens/main_page.dart';
import 'package:online_shop/screens/shopping_cart_screen.dart';
import 'package:online_shop/services/base_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ShoppingCartCard extends StatefulWidget {
  final OrderItem order_item;
  const ShoppingCartCard ({ Key key, this.order_item }): super(key: key);
  @override
  _ShoppingCartCardState createState() => _ShoppingCartCardState();
}

class _ShoppingCartCardState extends State<ShoppingCartCard> {

  void remove_item() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    final response = await http.post(
        BaseApiClient.REMOVE_ITEM_FROM_CART_URL,
        body: jsonEncode(<String, dynamic>{
          'product_id': widget.order_item.product.id,
        }),
        headers: BaseApiClient.getHeaders(token)
    );
    print(response.body);
    if(response.statusCode == 200){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => MainPage(child: ShoppingCartScreen(), title: "Shopping Cart",selected_index: 1,)),
              (Route<dynamic> route) => false
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget get shoppingCartCard {
    return new Card(
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: MeetNetworkImage(
              imageUrl: widget.order_item.product.image_url,
              loadingBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              errorBuilder: (context, e) => Center(
                child: Text('Error appear!'),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(widget.order_item.product.title),
            ],
          ),),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("\$" + widget.order_item.price.toString()),
            ],
          )),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(widget.order_item.quantity.toString()),
            ],
          )),
          InkWell(
            onTap: (){
              remove_item();
            },
            child: Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: shoppingCartCard,
    );
  }
}
