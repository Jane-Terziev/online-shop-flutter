import 'package:online_shop/models/order_item.dart';
import 'package:online_shop/models/product.dart';

class Cart {
  final int id;
  final String price;
  final String quantity;
  final List<OrderItem> order_items;

  Cart({this.id, this.price, this.quantity, this.order_items});

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orders = new List<OrderItem>();
    List items = json["items"];
    items.forEach((element) {
      OrderItem item = new OrderItem.fromJson(element);
      orders.add(item);
    });
    return new Cart(
        id: json['id'],
        price: json['price'],
        quantity: json['quantity'],
        order_items: orders
    );
  }
}