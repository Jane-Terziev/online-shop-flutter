import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';
import 'package:online_shop/widgets/view_product_card.dart';

import 'main_page.dart';

class ViewProductScreen extends StatefulWidget {
  final Product product;
  const ViewProductScreen ({ Key key, this.product }): super(key: key);
  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  @override
  Widget build(BuildContext context) {
    return MainPage(child: ViewProductCard(product: widget.product));
  }
}
