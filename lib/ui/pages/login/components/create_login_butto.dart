import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';
import './../login_presenter.dart';

class CreateLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(R.strings.dontHaveAnAccount),
        TextButton(
          child: Text(R.strings.addAccount),
            onPressed: presenter.goToSignUp,
            ),
      ],
    );
  }
}
