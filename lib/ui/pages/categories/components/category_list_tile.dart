import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import './../../products/products.dart';

class CategoryListTile extends StatelessWidget {
  final CategoryViewModel category;
  const CategoryListTile({@required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              category.description,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
