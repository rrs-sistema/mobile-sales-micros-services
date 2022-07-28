import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import './../../../../ui/helpers/services/services.dart';
import './../../../../domain/entities/entities.dart';
import './../../../../ui/common/common.dart';

class ItemTile extends StatelessWidget {
  final ProductEntity item;
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
                Expanded(child: Image.network(item.imgUrl)),
                Text(item.name, style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),),
                Text(UtilsServices().priceToCurrency(item.price), style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                  fontWeight: FontWeight.bold
                ),)            
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
                  topRight: Radius.circular(20)
                )
              ),
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
