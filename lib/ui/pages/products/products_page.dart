import 'package:delivery_micros_services/ui/pages/products/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import './../../../domain/entities/entities.dart';
import './../../../ui/common/common.dart';
import './components/components.dart';

class ProductPage extends StatefulWidget {

  final List<ProductViewModel> products;
  final List<CategoryEntity> categories;

  ProductPage({Key key, this.products, this.categories}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  CategoryEntity selectedCategory =
      CategoryEntity(id: 1000, description: 'Bíblia');

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text.rich(TextSpan(style: TextStyle(fontSize: 30), children: [
          TextSpan(text: 'Delivery Library ', style: TextStyle(fontSize: 22)),
          TextSpan(text: 'Services', style: TextStyle(fontSize: 22))
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
          Container(
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
                    isSelected:
                        widget.categories[index].id == selectedCategory.id,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: widget.categories.length),
          ),
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
                itemCount: widget.products.length,
                itemBuilder: (_, index) {
                  return ItemTile(
                    key: Key(
                      widget.products[index].id.toString(),
                    ),
                    item: widget.products[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
