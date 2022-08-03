import 'package:flutter/material.dart';

import './../../../../ui/pages/products/products.dart';
import './../../../../ui/helpers/helpers.dart';

class Error extends StatelessWidget {
  final ProductsPresenter presenter;
  final Color primaryColor;
  final String error;

  const Error(this.primaryColor, this.error, this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text.rich(TextSpan(style: TextStyle(fontSize: 30), children: [
          TextSpan(text: 'Delivery Library ', style: TextStyle(fontSize: 22)),
          TextSpan(text: 'Services', style: TextStyle(fontSize: 22))
        ])),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: presenter.loadData,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(R.strings.reload),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
