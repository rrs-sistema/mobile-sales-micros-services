import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListTile(
            title: Text('Sim'),
            leading: Radio(
              key: const ValueKey('adminSim'),
              value: 1,
              groupValue: val,
              onChanged: (admin) {
                presenter.validateAdmin(admin == 1 ? true : false);
                setState(() {
                  val = admin;
                });
              },
              activeColor: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text('Não'),
            leading: Radio(
              key: const ValueKey('adminNao'),
              value: 2,
              groupValue: val,
              onChanged: (admin) {
                presenter.validateAdmin(admin == 1 ? true : false);
                setState(() {
                  val = admin;
                });
              },
              activeColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
