import 'package:online_shop/models/product.dart';

class OrderItem {
  final int id;
  final int quantity;
  final double price;
  final Product product;

  OrderItem({
    this.id, this.quantity, this.product, this.price
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    Product product = new Product(
      id: json['product']['id'],
      title: json['product']['title'],
      image_url: json['product']['image']['url']
    );
    return new OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      price: double.parse(json['price']),
      product: product
    );
  }
}