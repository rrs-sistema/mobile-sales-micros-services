import 'package:flutter/material.dart';

import './../../../helpers/helpers.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Color primaryColor;
  final int currentIndex;
  final PageController pageController;

  const BottomNavigationBarWidget(this.primaryColor, this.currentIndex, this.pageController);

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) async {
          setState(() {
            widget.pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: widget.primaryColor,
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
        ]);
  }
}