import 'package:delivery_micros_services/ui/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../ui/helpers/services/services.dart';
import './../../../../ui/common/common.dart';
import './../../products/products.dart';

class ProductListTile extends StatelessWidget {
  final ProductViewModel item;
  final void Function(GlobalKey) cardAnimationMethod;
  final GlobalKey imageGk = GlobalKey();

  ProductListTile({required this.item, required this.cardAnimationMethod});

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    final presenter = Provider.of<ProductsPresenter>(context);
    return GestureDetector(
      key: Key('onClickProductListTile'),
      //onTap: () => presenter.goToDetailResult(item.id),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Provider(
              create: (_) => presenter, child: ProductsDetailsScreen(item.id));
        }));
      },
      child: Stack(
        children: [
          Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: item.imgUrl,
                      child: Image.network(
                        item.imgUrl,
                        key: imageGk,
                        errorBuilder: (context, url, error) => Image.asset(
                          'lib/ui/assets/sem-foto.jpg',
                          fit: BoxFit.fill,
                          errorBuilder: (context, url, error) => Image.asset(
                            'lib/ui/assets/sem-foto.jpg',
                          ),
                        ),
                      ),
                      /*
                      child: CachedNetworkImage(
                        key: imageGk,
                        height: 160,
                        imageUrl: item.imgUrl,
                        placeholder: (context, url) => Container(
                            width: 50.0,
                            child: const CircularProgressIndicator(
                              key: Key('progressIndicatorItemProduct'),
                            )),
                        errorWidget: (context, url, error) => Image.asset(
                          'lib/ui/assets/sem-foto.jpg',
                          fit: BoxFit.fill,
                          errorBuilder: (context, url, error) => Image.asset(
                            'lib/ui/assets/sem-foto.jpg',
                          ),
                        ),
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 3),
                      ),
                      */
                    ),
                  ),
                  Text(
                    item.name.length > 40
                        ? '${item.name.substring(0, 39)}...'
                        : item.name,
                    key: Key('itemProductName'),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        decoration: item.quantityAvailable < 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    UtilsServices().priceToCurrency(item.price),
                    style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: item.quantityAvailable < 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                cardAnimationMethod(imageGk);
              },
              child: Container(
                height: 40,
                width: 35,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(20))),
                child: const Icon(
                  Icons.add_shopping_cart_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
