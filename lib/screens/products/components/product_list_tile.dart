import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';

import '../../../domain/product.dart';

class ProductListTile extends StatelessWidget {
  ProductListTile(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductScreen.route_name, arguments: product);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images!.first),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      product.name!,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'A partir de',
                        style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ),
                    Text(
                      'R\$ 79,99',
                      style: TextStyle(fontSize: 15, color: primaryColor, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
