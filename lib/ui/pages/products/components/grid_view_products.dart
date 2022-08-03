import 'package:flutter/material.dart';

import './../../../../ui/pages/views_models/views_models.dart';
import './../components/components.dart';

class GridViewProducts extends StatelessWidget {
  const GridViewProducts({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<ProductViewModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 9 / 11.5,
        ),
        itemCount: products.length,
        itemBuilder: (_, index) {
          return ProductListTile(
            key: Key(
              products[index].id.toString(),
            ),
            item: products[index],
          );
        });
  }
}
