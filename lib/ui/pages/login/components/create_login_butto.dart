import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
        TextSpan(text: "Não tem uma conta? "),
        TextSpan(
          text: 'Criar ',
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
