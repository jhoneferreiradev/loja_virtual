import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../domain/product.dart';

class ProductService extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> allProducts = [];
  String _search = '';

  ProductService() {
    _loadAllProducts();
  }

  String get search => _search;
  void set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    List<Product> filteredProducts = [];

    filteredProducts.addAll(search.isEmpty
        ? allProducts
        : allProducts.where((product) =>
            product.name!.toLowerCase().contains(search.toLowerCase())).toList());

    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {
    QuerySnapshot querySnapshot = await firestore.collection('products').get();

    allProducts = querySnapshot.docs
        .map((doc) =>
            Product.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    notifyListeners();
  }
}
