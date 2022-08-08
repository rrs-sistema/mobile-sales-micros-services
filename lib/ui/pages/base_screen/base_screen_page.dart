import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './../../../main/factories/pages/signup/signup.dart';
import './../../pages/common_widgets/common_widgets.dart';
import './../../../ui/helpers/helpers.dart';
import './../../pages/orders/orders.dart';
import './components/components.dart';
import './../../common/common.dart';

import './../../mixins/mixins.dart';
import './../../pages/pages.dart';

class BasePageScreen extends StatelessWidget
    with SessionManager, NavigationManager {
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
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    title: Text.rich(TextSpan(style: TextStyle(fontSize: 30), children: [
                      TextSpan(text: R.strings.titleAppName, style: TextStyle(fontSize: 22, color: Colors.white,)),
                    ])),
                    centerTitle: true,
                  ),
                  body: GridView.count(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5,
                    children: List.generate(10,
                    (index) => CustomShimmer(
                          height: double.infinity,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(20),
                        ),),
                  ),
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
