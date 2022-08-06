import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../ui/common/common.dart';
import './../../../helpers/helpers.dart';
import '../login_presenter.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;

    return StreamBuilder<UIError?>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            /*
          decoration: ThemeHelper().textInputDecoration(
            'Email de usuário',
            'Digite seu e-mail de usuário',
            snapshot.data?.isEmpty == true ? null : snapshot.data
            ),
            */
            decoration: InputDecoration(
              labelText: R.strings.userEmail,
              errorText: snapshot.data?.description,
              labelStyle: TextStyle(
                color: primaryColor
              ),
            ),
            onChanged: presenter.validateEmail,
          );
        });
  }
}
