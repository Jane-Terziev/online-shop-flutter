import 'package:flutter/material.dart';
import 'package:online_shop/widgets/shopping_cart_list_view.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return ShoppingCartListView();
  }
}
