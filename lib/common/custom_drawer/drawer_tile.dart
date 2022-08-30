import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile({required this.iconData, required this.title, required this.page});

  final IconData iconData;
  final String title;
  final int page;

  @override
  Widget build(BuildContext context) {

    final _currentPage = context.watch<PageManager>().currentPage;

    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 30,
                color: (_currentPage == page) ? Colors.red : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: (_currentPage == page) ? Colors.red : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
