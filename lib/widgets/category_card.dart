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
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => change_visibility());
  }

  void change_visibility(){
    setState(() {
      _visible = true;
    });
  }

  Widget get categoryCard {
    return new AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: Card(
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
