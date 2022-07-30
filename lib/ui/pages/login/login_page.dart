import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../../ui/helpers/helpers.dart';
import './../../components/components.dart';
import './components/components.dart';
import './../../common/common.dart';
import './login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    Key _formKey = GlobalKey<FormState>();
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading == true) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        presenter.mainErrorStream.listen((error) {
          if (error != null) {
            showErrorMessage(context, error.description);
          }
        });
        
        presenter.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page);
          }
        });

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                    _headerHeight,
                    true,
                    Icons
                        .shopping_cart_outlined), //vamos criar um widget de cabeçalho comum
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // Este será o formulário de login
                  child: Column(
                    children: [
                      Text(
                        R.strings.titleAppName,
                        style: TextStyle(
                          color: primaryColor,
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        R.strings.loginToYourAccount,
                        style: TextStyle(color: primaryColor),
                      ),
                      SizedBox(height: 30.0),
                      Provider(
                        create: (_) => presenter,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: EmailInput(),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: PasswordInput(),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    //Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                  },
                                  child: Text(
                                    R.strings.forgotYourPassword,
                                    style: TextStyle(
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper()
                                    .buttonBoxDecoration(context),
                                child: LoginButton(),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: ToGoSignUpButton(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
