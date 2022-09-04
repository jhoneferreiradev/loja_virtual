import 'package:flutter/material.dart';
import 'package:loja_virtual/domain/product_size.dart';

class ProductSizeWidget extends StatelessWidget {
  const ProductSizeWidget({required this.productSize});

  final ProductSize productSize;

  @override
  Widget build(BuildContext context) {
    bool hasStock = productSize.hasStock;
    Color stockColorConditional =
        hasStock ? Colors.grey : Colors.red.withAlpha(50);
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: stockColorConditional)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: stockColorConditional,
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              productSize.name!,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "R\$ ${productSize.price!.toStringAsFixed(2)}",
              style: TextStyle(color: stockColorConditional),
            ),
          ),
        ],
      ),
    );
  }
}
