import 'package:flutter/material.dart';
import 'package:online_shop/widgets/bottom_navigation.dart';
import 'package:online_shop/widgets/categories_list_view.dart';
import 'package:online_shop/widgets/category_card.dart';


class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecommerce', style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: CategoriesListView(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
