import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import './../../../pages/common_widgets/common_widgets.dart';
import './../../../pages/orders/components/components.dart';
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
          initiallyExpanded: order.status == 'PENDING',
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
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  
                  // Lista de produtos
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        children: order.products.map((orderItem) {
                          return _OrderItem(utilsServices: utilsServices, orderItem: orderItem,);
                        }).toList(),
                      ),
                    ),
                  ),

                  // Divisão
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 8,
                  ),
                  
                  // Status do pedido
                  Expanded(
                    flex: 2,
                    child: OrderStatus(
                      status: order.status,
                      isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                    ),
                  ),

                ],
              ),
            ),

            // Total geral
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                ),
                children: [
                  const TextSpan(
                    text: 'Total ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                  TextSpan(
                    text: utilsServices.priceToCurrency(order.total),
                  )                  
                ]
              )
            ),

            // Botão pagamento
            Visibility(
              visible: order.status == 'PENDING',
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (_) {
                      return PaymentDialog(order: order);
                    });
                }, 
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                icon: Image.asset('lib/ui/assets/pix.png', height: 18,),
                label: const Text('Ver QR Code Pix'),
              ),
            ),

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
              fontSize: 12,
            ),
          ),
        ),   
        Text(
          utilsServices.priceToCurrency(orderItem.totalPrice()),
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),                                                 
       ],
      ),
    );
  }
}
