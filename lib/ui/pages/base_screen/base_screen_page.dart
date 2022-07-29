import 'package:flutter/material.dart';

import './../../../ui/components/components.dart';
import './../../../ui/helpers/helpers.dart';
import './../../../ui/common/common.dart';
import './../../../ui/pages/pages.dart';
import './../products/data/data.dart' as appData;

class BasePageScreen extends StatefulWidget {
  final ProductsPresenter presenter;
  BasePageScreen(this.presenter);

  @override
  _BasePageScreenState createState() => _BasePageScreenState();
}

class _BasePageScreenState extends State<BasePageScreen> {
  int _currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    widget.presenter.loadData();
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          if (isLoading == true) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });
        return StreamBuilder<List<ProductViewModel>>(
            stream: widget.presenter.loadProductsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    Text(snapshot.error),
                    ElevatedButton(
                      onPressed: () => null,
                      child: Text(R.strings.reload),
                    ),
                  ],
                );
              }
              if (snapshot.hasData) {
                return PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    ProductPage(
                      products: snapshot.data,
                      categories: appData.categories,
                    ),
                    Container(
                      color: Colors.yellow,
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
              return SizedBox(height: 0,);
            });
      }),
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
          ]),
    );
  }
}
