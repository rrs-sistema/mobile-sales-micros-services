

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../../pages/cart/components/components.dart';
import './../../helpers/services/services.dart';
import './../views_models/mocks/app_data.dart' as appData;
import './../../common/common.dart';

final UtilsServices utilsServices = UtilsServices();

class CartTab extends StatelessWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [


          Expanded(
            child: ListView.builder(
              itemCount: appData.cartItem.length,
              itemBuilder: (_, index) {
                return CartTile(cartItem: appData.cartItem[index]);
              },
            )),
        

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3,
                    spreadRadius: 2,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total geral',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  utilsServices.priceToCurrency(55.2),
                  style: TextStyle(
                    fontSize: 23,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: const Text('Concluir pedido', style: TextStyle(fontSize: 18),),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
