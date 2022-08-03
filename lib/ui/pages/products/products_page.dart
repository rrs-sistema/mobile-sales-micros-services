import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import './../views_models/views_models.dart';
import './../categories/categories.dart';
import './../../helpers/helpers.dart';
import './components/components.dart';
import './../../common/common.dart';

class ProductPage extends StatelessWidget {
  final List<ProductViewModel> products;

  ProductPage({Key key, this.products,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;

    final categories = products.map((cat) => cat.category).toList();
    List<CategoryViewModel> allCategories = [];
    categories.forEach((cat) {
      if (allCategories.where((ex) => ex.id == cat.id).length == 0) {
        allCategories.add(cat);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text.rich(TextSpan(style: TextStyle(fontSize: 30), children: [
          TextSpan(
              text: R.strings.titleAppName, style: TextStyle(fontSize: 22)),
          //TextSpan(text: 'Services', style: TextStyle(fontSize: 22))
        ])),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () => null,
              child: Badge(
                badgeContent: const Text(
                  '2',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: PesquiseAqui(primaryColor: primaryColor),
          ),
          CategoriesSeach(allCategories.toList(),),
          Expanded(
            child: GridViewProducts(products: products),
          )
        ],
      ),
    );
  }
}

