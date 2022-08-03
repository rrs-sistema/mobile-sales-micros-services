import 'package:flutter/material.dart';

import './../../../ui/helpers/helpers.dart';
import './../../../ui/common/common.dart';
import './../../../ui/pages/pages.dart';
import './components/components.dart';

class BasePageScreen extends StatefulWidget {
  final ProductsPresenter presenter;
  final CategoriesPresenter presenterCategory;

  BasePageScreen(this.presenter, this.presenterCategory);

  @override
  _BasePageScreenState createState() => _BasePageScreenState();
}

class _BasePageScreenState extends State<BasePageScreen> {
  int _currentIndex = 0;
  final pageController = PageController();


  @override
  Widget build(BuildContext context) {
    if(_currentIndex == 0)
      widget.presenter.loadData();
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: StreamBuilder<List<ProductViewModel>>(
          stream: widget.presenter.productsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Error(primaryColor, snapshot.error, widget.presenter);
            }
            if (snapshot.hasData) {
              return PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  ProductPage(
                    products: snapshot.data,
                    presenterCategory: widget.presenterCategory,
                  ),
                  Container(
                    color: Colors.green
                  ),
                  Container(
                    color: Colors.blue,
                  ),
                  Container(
                    color: Colors.purple,
                  ),
                ],
              );
            }
            return CircularProgress(
              'Carregando os produtos, aguarde...',
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) async {
            setState(() {
              _currentIndex = index;
              if (pageController.hasClients) 
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
          ]),
    );
  }
}
