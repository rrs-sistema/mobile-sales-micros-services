import 'package:flutter/material.dart';

import './../../../ui/common/common.dart';

void showLoading(BuildContext context) {
  final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => SimpleDialog(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(key: Key('circularProgressIndicatorShowLoading'), color: primaryColor,),
            SizedBox(
              height: 10,
            ),
            Text(
              'Aguarde...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
