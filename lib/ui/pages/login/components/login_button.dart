
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../utils/i18n/i18n.dart';
import './../../../common/common.dart';
import './../login_presenter.dart';

class LoginButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

     final presenter = Provider.of<LoginPresenter>(context);

    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          style: ThemeHelper().buttonStyle(),
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: Text(
              R.strings.logIn.toUpperCase(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          onPressed: snapshot.data == true ? presenter.auth : null
          /*
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          */
        );
      }
    );
  }
}
