import 'package:flutter/material.dart';
import 'package:online_shop/models/category.dart';
import 'package:online_shop/screens/products_screen.dart';


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
          child: InkWell(
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        category.image_url
                    ),
                    fit: BoxFit.cover),
              ),
              alignment: Alignment.center,
              child: Text(
                category.title, style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProductScreen(category_id: category.id.toString())),
                      (Route<dynamic> route) => false
              );
            },
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
