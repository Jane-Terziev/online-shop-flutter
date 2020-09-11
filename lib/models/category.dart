class Category {
  final int id;
  final String title;
  final String image_url;

  Category({this.id, this.title, this.image_url});

  factory Category.fromJson(Map<String, dynamic> json) {
    return new Category(
      id: json['id'],
      title: json['title'],
      image_url: json['image']['url']
    );
  }
}