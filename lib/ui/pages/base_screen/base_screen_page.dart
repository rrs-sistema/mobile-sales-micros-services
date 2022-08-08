
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../main/factories/pages/signup/signup.dart';
import './../../pages/orders/orders.dart';
import './components/components.dart';
import './../../common/common.dart';
import './../../mixins/mixins.dart';
import './../../pages/pages.dart';

class BasePageScreen extends StatelessWidget with SessionManager, NavigationManager {
  final ProductsPresenter presenter;

  BasePageScreen(this.presenter);

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    final pageController = PageController();

    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Builder(
        builder: (context) {
          handleSessionExpired(presenter.isSessionExpiredStream);
          handleNavigation(presenter.navigateToStream);
          presenter.loadData();
          return StreamBuilder<List<ProductViewModel>?>(
              stream: presenter.productsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Error(
                    primaryColor: primaryColor,
                    error: '${snapshot.error}',
                    presenter: presenter,
                  );
                }
                if (snapshot.hasData) {
                  return PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      Provider(
                        create: (_) => presenter,
                        child: ProductTab(products: snapshot.data!),
                      ),
                      CartTab(),
                      OrdersTab(),
                      makeSignUpTab(),
                    ],
                  );
                }
                return CircularProgress(
                  'Carregando os produtos, aguarde...',
                );
              });
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        primaryColor,
        _currentIndex,
        pageController,
      ),
    );
  }
}
