import 'category.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String image_url;
  final Category category;
  final String price;

  Product({this.id, this.title, this.description, this.image_url, this.category, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image_url: json['image']['url'],
        price: json['price']
    );
  }
}