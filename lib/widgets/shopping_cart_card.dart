import 'package:flutter/material.dart';
import 'package:meet_network_image/meet_network_image.dart';
import 'package:online_shop/models/order_item.dart';


class ShoppingCartCard extends StatefulWidget {
  final OrderItem order_item;
  const ShoppingCartCard ({ Key key, this.order_item }): super(key: key);
  @override
  _ShoppingCartCardState createState() => _ShoppingCartCardState();
}

class _ShoppingCartCardState extends State<ShoppingCartCard> {

  @override
  void initState() {
    super.initState();
  }

  Widget get shoppingCartCard {
    return new Card(
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            child: MeetNetworkImage(
              imageUrl: widget.order_item.product.image_url,
              loadingBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              errorBuilder: (context, e) => Center(
                child: Text('Error appear!'),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(widget.order_item.product.title),
            ],
          ),),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Price", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("\$" + widget.order_item.price.toString()),
            ],
          )),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(widget.order_item.quantity.toString()),
            ],
          )),
          InkWell(
            onTap: (){
            },
            child: Icon(
              Icons.close,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: shoppingCartCard,
    );
  }
}
