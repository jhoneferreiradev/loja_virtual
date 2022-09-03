import 'package:flutter/material.dart';
import 'package:loja_virtual/service/product_service.dart';
import 'package:provider/provider.dart';

import '../common/custom_drawer/custom_drawer.dart';
import '../common/search_dialog/search_dialog.dart';
import 'components/product_list_tile.dart';

class ProductsScreen extends StatelessWidget {
  void showDialogSearch(BuildContext context) async {
    final String? search = await showDialog<String>(
        context: context,
        builder: (_) {
          return SearchDialog(initialValue: context.read<ProductService>().search,);
        });
    context.read<ProductService>().search = (search != null) ? search : '';
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductService>(builder: (_, productService, __) {
          return productService.search.isEmpty
              ? const Text("Produtos")
              : LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () {
                    showDialogSearch(context);
                  },
                  child: Container(width: constraints.biggest.width, child: Text("Filtrando ${productService.search}", textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 3)),
                );
          });
        }),
        centerTitle: true,
        actions: [
          Consumer<ProductService>(
            builder: (_, productService, __) {
              return productService.search.isEmpty
                  ? IconButton(
                      onPressed: () {
                        showDialogSearch(context);
                      },
                      icon: Icon(Icons.search_rounded))
                  : IconButton(
                      onPressed: () {
                        context.read<ProductService>().search = '';
                      },
                      icon: Icon(Icons.close));
            },
          )
        ],
      ),
      body: Consumer<ProductService>(
        builder: (_, productService, __) {
          final filteredProducts = productService.filteredProducts;
          return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: filteredProducts.length,
              itemBuilder: (_, index) {
                return ProductListTile(filteredProducts[index]);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.shopping_cart,
          color: primaryColor,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
