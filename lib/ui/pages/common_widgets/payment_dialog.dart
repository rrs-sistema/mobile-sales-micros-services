import 'package:flutter/painting.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../..//helpers/services/utils_services.dart';
import './../../common/common.dart';
import './../../pages/pages.dart';

class PaymentDialog extends StatelessWidget {

  final OrderModel order;

  PaymentDialog({ Key? key, required this.order }) : super(key: key);

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [

          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com Pix',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),

                // QR Code
                QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 200.0,
                ),

                // Vencimento
                Text(
                  'Vencimento ${utilsServices.formatDateTime(order.overdueDateTime)}',
                  style: TextStyle(
                    fontSize: 12
                  ),
                ),      

                // Total
                Text(
                  'Total ${utilsServices.priceToCurrency(order.total)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ), 

                // Botão copia e cola
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    side: BorderSide(
                      width: 2,
                      color: primaryColor
                    )
                  ),
                  onPressed: () {
                    utilsServices.showToast(message: 'Código do PIX copiado.');
                  }, 
                  icon: const Icon(
                    Icons.copy, 
                    size: 15,
                  ), 
                  label: const Text(
                    'Copiar código Pix',
                      style: TextStyle(
                      fontSize: 13
                    ),
                  ),),

              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              icon: const Icon(Icons.close)
            ),
          ),
        ],
      ),
    );
  }
}