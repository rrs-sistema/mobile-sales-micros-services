import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';
import '../signup_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);

    return StreamBuilder<UIError>(
        stream: presenter.passwordErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.accessPassword,
              errorText: snapshot.hasData ? snapshot.data.description : null,
            ),
            obscureText: true,
            onChanged: presenter.validatePassword
          );
        });
  }
}