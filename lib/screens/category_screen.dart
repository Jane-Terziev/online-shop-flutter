import 'package:flutter/material.dart';
import 'package:online_shop/widgets/categories_list_view.dart';


class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return CategoriesListView();
  }
}
