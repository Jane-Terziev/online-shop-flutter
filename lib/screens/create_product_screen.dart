import 'package:flutter/material.dart';
import 'package:online_shop/widgets/product_form.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  @override
  Widget build(BuildContext context) {
    return ProductForm();
  }
}
