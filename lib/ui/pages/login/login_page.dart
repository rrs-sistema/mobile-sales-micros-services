import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/components.dart';
import 'components/components.dart';
import '../../widgets/widgets.dart';
import '../../common/common.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    void _hideKayboard() {
      final currectFocus = FocusScope.of(context);
      if (!currectFocus.hasPrimaryFocus) {
        currectFocus.unfocus();
      }
    }

    double _headerHeight = 250;
    Key _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showLoading(context);
          } else {
            hideLoading(context);
          }
        });

        presenter.mainErrorStream.listen((error) {
          print('Erro mainErrorStream $error');
          if (error != null) {
            showErrorMessage(context, error);
          }
        });
        
        presenter.navigateToStream.listen((page) {
          if (page?.isNotEmpty == true) {
            Get.offAllNamed(page);
          }
        });

        return GestureDetector(
          onTap: _hideKayboard,
          child: SingleChildScrollView(
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
                          'RRS Sales Micros Services',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Fazer login na sua conta',
                          style: TextStyle(color: Colors.grey),
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
                                      "Esqueceu sua senha?",
                                      style: TextStyle(
                                        color: Colors.grey,
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
                                  child: CreateLoginButton(),
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
          ),
        );
      }),
    );
  }
}
