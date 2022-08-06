import 'package:flutter/material.dart';

import './../../../common/common.dart';

class Quantity extends StatelessWidget {
  const Quantity({ Key? key }) : super(key: key);

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
        children: [
          _QuantityButton(color: Colors.grey, icon: Icons.remove, onPressed: () => null,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Text(' 1 ', style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),),
          ),
          _QuantityButton(color: primaryColor, icon: Icons.remove, onPressed: () => null,),
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