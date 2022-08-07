import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../../../pages/products_details/components/components.dart';
import './../../../helpers/services/utils_services.dart';
import './../../../pages/views_models/views_models.dart';
import './../../../common/common.dart';

class CartTile extends StatelessWidget {
  final CartItemViewModel cartItem;
  CartTile({Key? key, required this.cartItem}) : super(key: key);

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
          cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          cartItem.item.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(utilsServices.priceToCurrency(cartItem.totalPrice()),
        style: TextStyle(
          color: primaryColor,
            fontWeight: FontWeight.bold,
          )),
        trailing: Quantity(
            value: cartItem.quantity, suffixText: 'un', result: (quantity) {}),
      ),
    );
  }
}
