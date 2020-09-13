import 'package:online_shop/models/product.dart';

class Cart {
  final int id;
  final String price;
  final String quantity;
  final List<Product> products;

  Cart({this.id, this.price, this.quantity, this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    List items = json['items'];
    return new Cart(
        id: json['id'],
        price: json['price'],
        quantity: json['quantity'],
        products: items.map((product) => new Product.fromJson(product)).toList()
    );
  }
}