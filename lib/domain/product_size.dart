class ProductSize {
  factory ProductSize.fromJson(Map<String, dynamic> json) {
    return ProductSize(
        name: json['name'] as String,
        price: json['price'] as num,
        stock: json['stock'] as int);
  }

  ProductSize({this.name, this.price, this.stock});

  String? name;
  num? price;
  int? stock;

  bool get hasStock => (stock != null && stock! > 0);

  @override
  String toString() {
    return 'ProductSize{name: $name, price: $price, stock: $stock}';
  }
}
