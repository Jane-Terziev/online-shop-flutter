import 'package:flutter/material.dart';
import 'package:online_shop/models/product.dart';


class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard ({ Key key, this.product }): super(key: key);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
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

  Widget get productCard {
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
                      widget.product.image_url
                  ),
                  fit: BoxFit.cover),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.product.title, style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: (){

          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: productCard,
    );
  }
}
