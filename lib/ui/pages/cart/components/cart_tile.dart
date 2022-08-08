import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../../../pages/products_details/components/components.dart';
import './../../../helpers/services/utils_services.dart';
import './../../../pages/views_models/views_models.dart';
import './../../../common/common.dart';

class CartTile extends StatefulWidget {
  final CartItemViewModel cartItem;
  final Function(CartItemViewModel) remove;
  const CartTile({Key? key, required this.cartItem, required this.remove}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          widget.cartItem.item.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
        style: TextStyle(
          color: primaryColor,
            fontWeight: FontWeight.bold,
          )),
        trailing: Quantity(
            value: widget.cartItem.quantity, suffixText: 'un', isRemovable: true, result: (quantity) {
              setState(() {
                widget.cartItem.quantity = quantity;
                if(quantity == 0){
                  widget.remove(widget.cartItem);
                }
              });
            }),
      ),
    );
  }
}
