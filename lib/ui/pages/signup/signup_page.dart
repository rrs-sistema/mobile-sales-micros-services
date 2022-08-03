import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

import './../../../ui/helpers/helpers.dart';
import './components/components.dart';
import './../../mixins/mixins.dart';
import './../../common/common.dart';
import './signup_presenter.dart';

class SignUpPage extends StatelessWidget with KeyboardManager, LoadingManager, UIErrorManager, NavigationManager  {
  final SignUpPresenter presenter;
  const SignUpPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 250;
    Key _formKey = GlobalKey<FormState>();
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        handleLoading(context, presenter.isLoadingStream);
        handleMainError(context, presenter.mainErrorStream);
        handleNavigation(presenter.navigateToStream, clear: true);       
        return GestureDetector(
          onTap: () => hideKeyboard,
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
                          R.strings.titleAppName,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          R.strings.createAnAccoun,
                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Provider(
                          create: (_) => presenter,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  child: NameInput(),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30.0),
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
                                SizedBox(height: 30.0),
                                Container(
                                  child: ConfirmPasswordInput(),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30.0),
                                Text("Usuário é administrador",
                                    style: TextStyle(fontSize: 16, color: primaryColor,)),
                                SizedBox(height: 10.0),
                                Container(
                                  child: RadioUserAdmin(),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  child: CheckAcceptTermAndCondition(),
                                  decoration:
                                      ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  decoration:
                                      ThemeHelper().buttonBoxDecoration(context),
                                  child: SignUpButton(),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: ToGoLoginButton(),
                                ),
                                Text(
                                  R.strings.createAccountWithSocial,
                                  style: TextStyle(color: primaryColor,),
                                ),
                                SizedBox(height: 25.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: FaIcon(
                                        FontAwesomeIcons.googlePlus,
                                        size: 35,
                                        color: HexColor("#EC2D2F"),
                                      ),
                                      onTap: () {
                                        // setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Google Plus",
                                                "You tap on GooglePlus social icon.",
                                                context);
                                          },
                                        );
                                        //});
                                      },
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 5,
                                              color: HexColor("#40ABF0")),
                                          color: HexColor("#40ABF0"),
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.twitter,
                                          size: 23,
                                          color: HexColor("#FFFFFF"),
                                        ),
                                      ),
                                      onTap: () {
                                        //setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Twitter",
                                                "You tap on Twitter social icon.",
                                                context);
                                          },
                                        );
                                        //});
                                      },
                                    ),
                                    SizedBox(
                                      width: 30.0,
                                    ),
                                    GestureDetector(
                                      child: FaIcon(
                                        FontAwesomeIcons.facebook,
                                        size: 35,
                                        color: HexColor("#3E529C"),
                                      ),
                                      onTap: () {
                                        //setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Facebook",
                                                "You tap on Facebook social icon.",
                                                context);
                                          },
                                        );
                                        //});
                                      },
                                    ),
                                  ],
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
