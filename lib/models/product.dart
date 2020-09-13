
import 'category.dart';
import 'user.dart';

class Product {
  final int id;
  final String title;
  final String description;
  final String image_url;
  final List<Category> categories;
  final String price;
  final String in_stock;
  final User user;

  Product({
    this.id,
    this.title,
    this.description,
    this.image_url,
    this.categories,
    this.price,
    this.in_stock,
    this.user
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List categories_list = json['categories'];
    List<Category> categories = [];
    for(final category in categories_list){
      categories.add(Category.fromJson(category));
    }
    User user = User.fromJson(json['user']);
    return new Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image_url: json['image']['url'],
        price: json['price'].toString(),
        in_stock: json['in_stock'].toString(),
        categories: categories,
        user: user
    );
  }
}