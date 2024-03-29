import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeHelper{

  ThemeData makeAppTheme() {
    Color _primaryColor = HexColor('#DC54FE');
    Color _accentColor = HexColor('#8A02AE');
    MaterialColor primarySwatch = MaterialColor(_primaryColor.value, {
      50:  _primaryColor,
      100: _primaryColor,
      200: _primaryColor,
      300: _primaryColor,
      400: _primaryColor,
      500: _primaryColor,
      600: _primaryColor,
      700: _primaryColor,
      800: _primaryColor,
      900: _primaryColor,
    });
    return ThemeData(
        primaryColor: _primaryColor,
        secondaryHeaderColor: _accentColor,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
        primarySwatch: primarySwatch,
      );
  }

  InputDecoration textInputDecoration([String lableText= '', String hintText = '', String? errorText]){
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      errorText: errorText,
      fillColor: Colors.white,
      labelStyle: TextStyle(color: primaryColor),
      hintStyle: TextStyle(color: primaryColor),      
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: primaryColor.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(BuildContext context, [String color1 = "", String color2 = ""]) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).secondaryHeaderColor;
    if (color1.isEmpty == false) {
      c1 = HexColor(color1);
    }
    if (color2.isEmpty == false) {
      c2 = HexColor(color2);
    }

    return BoxDecoration(
      boxShadow: [
        BoxShadow(color: primaryColor, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}
