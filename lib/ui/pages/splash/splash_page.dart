import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../ui/common/common.dart';
import './splash_presenter.dart';

class SplashPage extends StatelessWidget {
  final SplashPresenter presenter;

  SplashPage({@required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text.rich(TextSpan(style: TextStyle(fontSize: 30), children: [
          TextSpan(text: 'Delivery Library ', style: TextStyle(fontSize: 22)),
          TextSpan(text: 'Services', style: TextStyle(fontSize: 22))
        ])),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          presenter.navigateToStream.listen((page) {
            if (page?.isNotEmpty == true) {
              Get.offAllNamed(page);
            }
          });
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
