import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.accessPassword,
            ),
            obscureText: true,
            onChanged: null
          );
  }
}
