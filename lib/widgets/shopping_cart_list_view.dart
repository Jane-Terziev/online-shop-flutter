import 'package:flutter/material.dart';
import 'package:online_shop/models/order_item.dart';

import 'shopping_cart_card.dart';

class ShoppingCartListView extends StatefulWidget {
  final List<OrderItem> order_items;
  const ShoppingCartListView ({ Key key, this.order_items }): super(key: key);
  @override
  _ShoppingCartListViewState createState() => _ShoppingCartListViewState();
}

class _ShoppingCartListViewState extends State<ShoppingCartListView> {
  @override
  Widget build(BuildContext context) {
     return ShoppingCartCard(order_item: widget.order_items[0]);
  }
}
