import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String>(
        stream: presenter.passwordErroStream,
        builder: (context, snapshot) {
          return TextFormField(
            /*
          decoration: ThemeHelper().textInputDecoration(
            'Senha de acesso',
            'Digite sua senha',
            snapshot.data?.isEmpty == true ? null : snapshot.data
            ),
            */
            decoration: InputDecoration(
              labelText: 'Senha de acesso',
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
            ),
            obscureText: true,
            onChanged: presenter.validatePassword
          );
        });
  }
}
