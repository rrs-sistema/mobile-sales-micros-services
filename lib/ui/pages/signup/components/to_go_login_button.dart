import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';
import './../signup_presenter.dart';

class ToGoLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(R.strings.alreadyHaveAnAccount),
        TextButton(
          child: Text(R.strings.logIn),
            onPressed: presenter.goToLogin,
            ),
      ],
    );
  }
}
