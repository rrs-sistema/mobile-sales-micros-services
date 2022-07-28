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
        title: Text('RRS Sales Micros Services'),
      ),
      body: Builder(
        builder: (context) {
          presenter.navigateToStream.listen((page) {
            if(page?.isNotEmpty == true) {
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