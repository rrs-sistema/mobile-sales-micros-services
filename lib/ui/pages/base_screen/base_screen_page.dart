import 'package:flutter/material.dart';

import './../../../ui/helpers/helpers.dart';
import './../../../ui/common/common.dart';
import './../../../ui/pages/pages.dart';

class BasePageScreen extends StatefulWidget {

  BasePageScreen({ Key key }) : super(key: key);

  @override
  _BasePageScreenState createState() => _BasePageScreenState();
}

class _BasePageScreenState extends State<BasePageScreen> {
  int _currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ProductPage(),
          Container(color: Colors.yellow,),
          Container(color: Colors.blue,),
          Container(color: Colors.purple,),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withAlpha(100),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: R.strings.titleNavBarHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: R.strings.titleNavBarCarrinho,
          ),    
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: R.strings.titleNavBarPedido,
          ),         
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: R.strings.titleNavBarPerfil,
          ),                 
        ]
      ),
    );
  }
}