import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#8A02AE');

    return new MaterialApp(
      title: 'Vendas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: new LoginPage(),
    );
  }
}