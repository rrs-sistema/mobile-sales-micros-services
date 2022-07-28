import 'package:delivery_micros_services/main/factories/pages/base_screen/base_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './factories/factories.dart';
import '../ui/common/common.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  //R.load(Locale('en', 'US'));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return new GetMaterialApp(
      title: 'Vendas',
      debugShowCheckedModeBanner: false,
      theme: ThemeHelper().makeAppTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(name: '/signup', page: makeSignUpPage),
        GetPage(name: '/base_screen', page: makeBaseScreenPage, transition: Transition.fadeIn),
        GetPage(name: '/products', page: makeProductsPage, transition: Transition.fadeIn)
      ],
    );
  }
}