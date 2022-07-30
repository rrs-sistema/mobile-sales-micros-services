import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../ui/common/common.dart';
import './../../../helpers/helpers.dart';
import './../login_presenter.dart';

class ToGoSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          R.strings.dontHaveAnAccount,
          style: TextStyle(
            color: primaryColor,
          ),
        ),
        TextButton(
          child: Text(
            R.strings.addAccount,
            style: TextStyle(
              color: primaryColor,
            ),
          ),
          onPressed: presenter.goToSignUp,
        ),
      ],
    );
  }
}
