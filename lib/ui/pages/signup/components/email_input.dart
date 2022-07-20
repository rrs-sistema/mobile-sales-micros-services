import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: R.strings.userEmail,
      ),
      onChanged: (value) {},
    );
  }
}
