import 'package:flutter/material.dart';

class RadioUserAdmin extends StatefulWidget {
  @override
  _RadioUserAdmintate createState() => _RadioUserAdmintate();
}

class _RadioUserAdmintate extends State<RadioUserAdmin> {
  int val = 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListTile(
            title: Text("Sim"),
            leading: Radio(
              key: const ValueKey('adminSim'),
              value: 1,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value;
                });
              },
              activeColor: Colors.green,
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text("Não"),
            leading: Radio(
              key: const ValueKey('adminNao'),
              value: 2,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value;
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
