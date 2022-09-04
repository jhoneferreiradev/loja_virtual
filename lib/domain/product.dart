import 'package:loja_virtual/domain/product_size.dart';

class Product {
  String? id;
  String? name;
  String? description;
  List<String>? images = [];
  List<ProductSize>? productSizes;

  Product(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.productSizes});

  bool get hasProductSizes => (productSizes != null && productSizes!.isNotEmpty);

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'images': images, 'product_sizes': this.productSizes};
  }

  factory Product.fromJson(Map<String, dynamic> json, String uid) => Product(
      id: uid,
      name: json['name'],
      description: json['description'],
      images: List<String>.from(json['images'] as List<dynamic>),
      productSizes: (json['product_sizes'] as List<dynamic>? ?? [])
          .map((ps) => ProductSize.fromJson(ps as Map<String, dynamic>))
          .toList());

  @override
  String toString() {
    return toJson().toString();
  }
}
