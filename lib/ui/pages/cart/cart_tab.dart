import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './../../pages/cart/components/components.dart';
import './../../pages/views_models/views_models.dart';
import './../../helpers/services/services.dart';
import './../views_models/mocks/app_data.dart' as appData;
import './../../common/common.dart';

final UtilsServices utilsServices = UtilsServices();

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  void removeItemFromCart(CartItemViewModel cartItem) {
    setState(() {
      appData.cartItens.remove(cartItem);
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in appData.cartItens) {
      total += item.totalPrice();
    }
    return total;
  }

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
            itemCount: appData.cartItens.length,
            itemBuilder: (_, index) {
              return CartTile(
                cartItem: appData.cartItens[index],
                remove: removeItemFromCart,
              );
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
                  utilsServices.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 23,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Concluir pedido',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async{
                      bool? result = await showOrderConfirmation();
                      print('Result: $result');
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Confirmação'),
            content: const Text('Deseja realmente concluir o pedido?'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop(false);
              }, child: const Text('Não')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Sim'))
            ],
          );
        });
  }
}
