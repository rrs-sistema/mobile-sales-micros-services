
import 'package:flutter/material.dart';

class PesquiseAqui extends StatelessWidget {
  const PesquiseAqui({
    Key key,
    @required this.primaryColor,
  }) : super(key: key);

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          hintText: 'Pesquise aqui...',
          hintStyle: TextStyle(color: primaryColor, fontSize: 14),
          prefixIcon: Icon(
            Icons.search,
            color: primaryColor,
            size: 22,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60),
              borderSide:
                  const BorderSide(width: 0, style: BorderStyle.none))),
    );
  }
}
