import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../login_presenter.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<String>(
        stream: presenter.emailErroStream,
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
              labelText: 'Email de usuário',
              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
            ),
            onChanged: presenter.validateEmail,
          );
        });
  }
}
