import 'package:flutter/material.dart';

import './../../../ui/common/common.dart';
import './../../mixins/mixins.dart';
import './splash_presenter.dart';

class SplashPage extends StatelessWidget with NavigationManager  {
  final SplashPresenter presenter;

  SplashPage({required this.presenter});

  @override
  Widget build(BuildContext context) {
    presenter.checkAccount();
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text.rich(TextSpan(style: TextStyle(fontSize: 30), children: [
          TextSpan(text: 'Delivery Library ', style: TextStyle(fontSize: 22)),
          TextSpan(text: 'Services', style: TextStyle(fontSize: 22))
        ])),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          handleNavigation(presenter.navigateToStream, clear: true);
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
