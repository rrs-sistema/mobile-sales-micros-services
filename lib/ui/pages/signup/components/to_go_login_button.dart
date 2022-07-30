import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../ui/common/common.dart';
import './../../../helpers/helpers.dart';
import './../signup_presenter.dart';

class ToGoLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(R.strings.alreadyHaveAnAccount, style: TextStyle(color: primaryColor,)),
        TextButton(
          child: Text(R.strings.logIn, style: TextStyle(color: primaryColor,)),
            onPressed: presenter.goToLogin,
            ),
      ],
    );
  }
}
