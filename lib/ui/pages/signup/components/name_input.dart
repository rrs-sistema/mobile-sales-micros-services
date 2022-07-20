import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';
import '../signup_presenter.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<UIError>(
        stream: presenter.nameErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.userName,
              errorText: snapshot.hasData ? snapshot.data.description : null,
            ),
            onChanged: presenter.validateName,
          );
        });
  }
}