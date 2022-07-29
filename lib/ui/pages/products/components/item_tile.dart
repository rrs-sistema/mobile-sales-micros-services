import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import './../../../../ui/helpers/services/services.dart';
import './../../../../ui/common/common.dart';
import './../../products/products.dart';

class ItemTile extends StatelessWidget {
  final ProductViewModel item;
  const ItemTile({@required Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Stack(
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
                  child: CachedNetworkImage(
                    height: 170,
                    imageUrl: item.imgUrl,
                    placeholder: (context, url) => const CircularProgressIndicator(key: Key('progressIndicatorItemProduct'),),
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
                ),
                Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  UtilsServices().priceToCurrency(item.price),
                  style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => null,
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
    );
  }
}
