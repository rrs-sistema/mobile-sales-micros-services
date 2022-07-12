import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../helpers/errors/errors.dart';
import './../../../../utils/i18n/i18n.dart';
import '../login_presenter.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<UIError>(
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
              errorText: snapshot.hasData ? snapshot.data.description : null,
            ),
            onChanged: presenter.validateEmail,
          );
        });
  }
}
