import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';

class CreateLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: R.strings.dontHaveAnAccount),
        TextSpan(
          text: R.strings.addAccount,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
            },
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
      ]),
    );
  }
}
