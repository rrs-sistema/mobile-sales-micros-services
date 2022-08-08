import 'package:flutter/material.dart';

import './../../../../ui/pages/views_models/views_models.dart';
import './../../../../ui/common/common.dart';

class CategoryTile extends StatelessWidget {
  
  const CategoryTile({ required this.category, required this.isSelected, required this.onPressed });

  final CategoryViewModel category;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? primaryColor : Colors.transparent
          ),
          child: Text(
            category.description,
            style: TextStyle(
              color: isSelected ? Colors.white : primaryColor,
              fontSize: isSelected ? 16 : 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}