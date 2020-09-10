import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_shop/models/category.dart';
import 'package:online_shop/services/base_api_client.dart';
import 'package:online_shop/services/category_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'category_card.dart';


class CategoriesListView extends StatefulWidget {
  @override
  _CategoriesListViewState createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  List<Category> data;
  bool _progressController = true;

  Future<List<Category>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    print(token);
    if(token != null) {
      final response = await http.get(BaseApiClient.CATEGORY_URL, headers: BaseApiClient.getHeaders(token));
      if (response.statusCode == 200) {
        Map jsonResponse = json.decode(response.body);
        List items = jsonResponse['items'];
        return items.map((category) => new Category.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories from API');
      }
    }
    else {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  void initState(){
    super.initState();
    this.getData().then((value) {
      setState(() {
        data = value;
        _progressController = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _progressController
        ? CircularProgressIndicator()
        : ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: data[index]);
        }
    );
  }
}