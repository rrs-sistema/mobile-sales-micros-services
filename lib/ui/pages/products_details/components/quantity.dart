import 'package:flutter/material.dart';

import './../../../common/common.dart';

class Quantity extends StatelessWidget {
  final int value;
  final String suffixText;
  final Function(int quantity) result;

  const Quantity({ required this.value, required this.suffixText, required this.result});

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityButton(color: Colors.grey, icon: Icons.remove, onPressed: () {
              if(value == 1)return;
              
              int resultCount = value - 1;
              result(resultCount);
            },),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(' $value$suffixText', style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
            ),),
          ),
          _QuantityButton(color: primaryColor, icon: Icons.remove, onPressed: () {
              int resultCount = value + 1;
              result(resultCount);
          },),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({
    Key? key, required this.color, required this.icon, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}