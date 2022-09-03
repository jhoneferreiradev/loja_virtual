class Product {
  String? id;
  String? name;
  String? description;
  List<String>? images = [];

  Product({this.id, this.name, this.description, this.images});

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'images' : images};
  }

  factory Product.fromJson(Map<String, dynamic> json, String uid) =>
      Product(id: uid, name: json['name'], description: json['description'], images: List<String>.from(json['images'] as List<dynamic>));

  @override
  String toString() {
    return toJson().toString();
  }
}