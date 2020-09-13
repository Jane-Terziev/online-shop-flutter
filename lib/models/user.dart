class User {
  final int id;
  final String image_url;
  final String first_name;
  final String last_name;
  final int gender;
  final String email;
  final int age;

  User({
    this.id,
    this.image_url,
    this.first_name,
    this.last_name,
    this.email,
    this.age,
    this.gender
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
        id: json['id'],
        image_url: json['image']['url'],
        last_name: json['last_name'],
      first_name: json['first_name'],
      age: json['age'],
      email: json['email'],
      gender: json['gender'],
    );
  }
}