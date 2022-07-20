import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';

class ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
return TextFormField(
            decoration: InputDecoration(
              labelText: R.strings.confirmPassword,
            ),
            obscureText: true,
            onChanged: null
          );
  }
}
