import 'package:flutter/material.dart';
import 'package:online_shop/widgets/products_list_view.dart';


class ProductScreen extends StatefulWidget {
  final String category_id;
  const ProductScreen ({ Key key, this.category_id }): super(key: key);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ProductsListView(category_id: widget.category_id);
  }
}
