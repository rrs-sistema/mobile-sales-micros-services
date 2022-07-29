import 'package:flutter/material.dart';

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
      body: StreamBuilder<List<ProductViewModel>>(
          stream: widget.presenter.productsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  elevation: 0,
                  title: Text.rich(
                      TextSpan(style: TextStyle(fontSize: 30), children: [
                    TextSpan(
                        text: 'Delivery Library ',
                        style: TextStyle(fontSize: 22)),
                    TextSpan(text: 'Services', style: TextStyle(fontSize: 22))
                  ])),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.error,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: widget.presenter.loadData,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            child: Text(R.strings.reload),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Carregando dados, aguarde...', style: TextStyle(
                  color: Colors.white,
                ), textAlign: TextAlign.center),
                const SizedBox(height: 15,),
                const CircularProgressIndicator(
                  key: Key("circularLoadProduct"),
                  color: Colors.white,
                )
              ],
            ));
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
