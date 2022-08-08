import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import './../../helpers/services/services.dart';
import './../views_models/views_models.dart';
import './../categories/categories.dart';
import './../../helpers/helpers.dart';
import './components/components.dart';
import './../../common/common.dart';

class ProductTab extends StatefulWidget {
  final List<ProductViewModel> products;

  ProductTab({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {

  final GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  final UtilsServices utilsServices = UtilsServices();

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    List<CategoryViewModel> allCategories = [];
 
    final categories = widget.products.map((cat) => cat.category).toList(); 
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
          TextSpan(text: R.strings.titleAppName, style: TextStyle(fontSize: 22, color: Colors.white,)),
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
                child: AddToCartIcon(icon: const Icon(Icons.shopping_cart), key: globalKeyCartItems,),
              ),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCartAnimation = addToCardAnimationMethod;
        },
        child: Column(
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
                  return ProductListTile(
                    cardAnimationMethod: itemSelectedCartAnimations, item: widget.products[index]);
                }),
            ),           
          ],
        ),
      ),
    );
  }

}

