import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import './../../../ui/pages/views_models/views_models.dart';
import './../../../ui/pages/categories/categories.dart';
import './../../../ui/helpers/helpers.dart';
import './../../../ui/common/common.dart';
import './components/components.dart';

class ProductPage extends StatelessWidget {
  final List<ProductViewModel> products;
  final CategoriesPresenter presenterCategory;

  ProductPage({Key key, this.products, this.presenterCategory})
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
            child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui...',
                  hintStyle: TextStyle(color: primaryColor, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.search,
                    color: primaryColor,
                    size: 22,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
          ),
          CategoriesSeach(allCategories.toList(),
          ),
          // Container(
          //   height: 40,
          //   padding: const EdgeInsets.only(left: 25),
          //   child: ListView.separated(
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (_, index) {
          //         return CategoryTile(
          //           onPressed: () {
          //             setState(() {
          //               selectedCategory = widget.categories[index];
          //             });
          //           },
          //           category: widget.categories[index],
          //           isSelected:
          //               widget.categories[index].id == selectedCategory.id,
          //         );
          //       },
          //       separatorBuilder: (_, index) => const SizedBox(
          //             width: 10,
          //           ),
          //       itemCount: widget.categories.length),
          // ),
          Expanded(
            child: GridView.builder(
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
                }),
          )
        ],
      ),
    );
  }
}
