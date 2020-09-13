import 'package:flutter/material.dart';
import 'package:online_shop/models/category.dart';
import 'package:online_shop/screens/main_page.dart';
import 'package:online_shop/screens/products_screen.dart';


class CategoryCard extends StatefulWidget {
  final Category category;
  const CategoryCard ({ Key key, this.category }): super(key: key);
  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
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
                      widget.category.image_url
                  ),
                  fit: BoxFit.cover),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.category.title, style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage(
                child: ProductScreen(category_id: widget.category.id.toString()),
                title: widget.category.title,
              ),
              ),
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
