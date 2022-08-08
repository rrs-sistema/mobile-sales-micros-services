import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../../../pages/views_models/views_models.dart';
import './../../../helpers/services/services.dart';
import './../../../common/common.dart';

class OrderTile extends StatelessWidget {

  final OrderModel order;

  OrderTile({ required this.order });

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido: ${order.id}',
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
              Text(
                utilsServices.formatDateTime(order.createdDateTime),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),              
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: order.products.map((orderItem) {
                        return _OrderItem(utilsServices: utilsServices, orderItem: orderItem,);
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({
    Key? key,
    required this.utilsServices, required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemViewModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
       children: [
        Text(
          '${orderItem.quantity} un - ',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        Expanded(
          child: Text(orderItem.item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),   
        Text(
          utilsServices.priceToCurrency(orderItem.totalPrice()),
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),                                                 
       ],
      ),
    );
  }
}
