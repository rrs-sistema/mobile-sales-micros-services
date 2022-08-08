import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../../ui/helpers/helpers.dart';
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
      title: R.strings.titleAppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeHelper().makeAppTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: makeSplashPage, transition: Transition.fade),
        GetPage(name: '/login', page: makeLoginPage, transition: Transition.fadeIn),
        GetPage(name: '/signup', page: makeSignUpTab),
        GetPage(name: '/base_screen', page: makeBaseScreenPage, transition: Transition.fadeIn),
        //GetPage(name: '/products', page: makeProductsPage, transition: Transition.fadeIn),
        GetPage(name: '/categories', page: makeCategoriesPage, transition: Transition.fadeIn),
        GetPage(name: '/detail_result/:product_id', page: makeProductsDetailsScreen),
      ],
    );
  }
}