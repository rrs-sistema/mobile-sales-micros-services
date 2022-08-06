import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../../ui/common/common.dart';
import '../signup_presenter.dart';

class RadioUserAdmin extends StatefulWidget {
  @override
  _RadioUserAdmintate createState() => _RadioUserAdmintate();
}

class _RadioUserAdmintate extends State<RadioUserAdmin> {
  int val = -1;

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListTile(
            title: Text('Sim', style: TextStyle(color: primaryColor,)),
            leading: Radio(
              key: const ValueKey('adminSim'),
              value: 1,
              groupValue: val,
              onChanged: (admin) {
                presenter.validateAdmin(admin == 1 ? true : false);
                setState(() {
                  val = admin == 1 ? 1 : 0;
                });
              },
              activeColor: primaryColor,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text('Não', style: TextStyle(color: primaryColor,)),
            leading: Radio(
              key: const ValueKey('adminNao'),
              value: 2,
              groupValue: val,
              onChanged: (admin) {
                presenter.validateAdmin(admin == 1 ? true : false);
                setState(() {
                  val = admin == 1 ? 1 : 0;
                });
              },
              activeColor: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
