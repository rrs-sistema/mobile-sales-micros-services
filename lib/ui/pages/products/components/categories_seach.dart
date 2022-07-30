import 'package:flutter/material.dart';

import './../../../../ui/pages/products/components/category_tile.dart';
import './../../../../ui/pages/views_models/category_view_model.dart';

class CategoriesSeach extends StatefulWidget {
  final List<CategoryViewModel> categories;

  const CategoriesSeach(this.categories);

  @override
  _CategoriesSeachState createState() => _CategoriesSeachState();
}

class _CategoriesSeachState extends State<CategoriesSeach> {
  CategoryViewModel selectedCategory =
      CategoryViewModel(id: 1000, description: 'Bíblia');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: 25),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return CategoryTile(
                onPressed: () {
                  setState(() {
                    selectedCategory = widget.categories[index];
                  });
                },
                category: widget.categories[index],
                isSelected: widget.categories[index].id == selectedCategory.id,
              );
            },
            separatorBuilder: (_, index) => const SizedBox(
                  width: 10,
                ),
            itemCount: widget.categories.length),
      ),
    );
  }
}
