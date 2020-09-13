import 'package:flutter/material.dart';
import 'package:meet_network_image/meet_network_image.dart';
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
          onTap: (){

          },
          child: Container(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: MeetNetworkImage(
                      imageUrl: widget.product.image_url,
                      loadingBuilder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorBuilder: (context, e) => Center(
                        child: Text('Error appear!'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            widget.product.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Flexible(child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "\$" + widget.product.price,
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          )
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