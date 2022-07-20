import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';

class CheckAcceptTermAndCondition extends StatefulWidget {
  @override
  _CheckAcceptTermAndConditionState createState() => _CheckAcceptTermAndConditionState();
}

class _CheckAcceptTermAndConditionState extends State<CheckAcceptTermAndCondition> {
  bool _value = false;
  int val = 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
                //state.didChange(value);
              });
            }),
        Text(R.strings.acceptanceTerm,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
