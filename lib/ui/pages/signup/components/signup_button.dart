import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';
import './../../../common/common.dart';
import './../signup_presenter.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ThemeHelper().buttonStyle(),
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: Text(
              R.strings.addAccount.toUpperCase(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: snapshot.data == true ? Colors.white : Colors.grey),
            ),
          ),
          onPressed: snapshot.data == true ? presenter.signUp : null
        );
      }
    );
  }
  
}
