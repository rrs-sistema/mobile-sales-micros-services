import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../ui/common/common.dart';
import './../../../helpers/helpers.dart';
import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;

    return StreamBuilder<UIError?>(
        stream: presenter.passwordErrorStream,
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
              labelText: R.strings.accessPassword,
              errorText: snapshot.data?.description,
              labelStyle: TextStyle(
                color: primaryColor
              ),
            ),
            obscureText: true,
            onChanged: presenter.validatePassword
          );
        });
  }
}
