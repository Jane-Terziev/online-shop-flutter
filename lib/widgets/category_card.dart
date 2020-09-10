import 'package:flutter/material.dart';
import 'package:online_shop/models/category.dart';


class CategoryCard extends StatefulWidget {
  CategoryCard({this.category});
  Category category;
  @override
  _CategoryCardState createState() => _CategoryCardState(category: category);
}

class _CategoryCardState extends State<CategoryCard> {
  _CategoryCardState({this.category});
  Category category;

  Widget get categoryCard {
    return new Card(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network("https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/MDA2018_inline_03.jpg"),
          Text(
              category.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: categoryCard,
    );
  }
}
