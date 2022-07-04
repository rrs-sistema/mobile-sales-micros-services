import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import 'components/components.dart';
import '../../widgets/widgets.dart';
import '../../common/common.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {

  final LoginPresenter presenter;
  const LoginPage({Key key, this.presenter}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose(){
    super.dispose();
    widget.presenter.dispose();
  }

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if(isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if(error != null) {
              showErrorMessage(context, error);
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
                        .login_rounded), //vamos criar um widget de cabeçalho comum
              ),
              SafeArea(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    margin: EdgeInsets.fromLTRB(
                        20, 10, 20, 10), // Este será o formulário de login
                    child: Column(
                      children: [
                        Text(
                          'Delivery Micros Services',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Fazer login na sua conta',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
                        Provider(
                          create: (_) => widget.presenter,
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
                                    child: StreamBuilder<String>(
                                      stream: widget.presenter.passwordErroStream,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Senha de acesso',
                                            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                                          ),
                                          onChanged: widget.presenter.validatePassword,                                  
                                          /*
                                          obscureText: true,
                                          decoration: ThemeHelper().textInputDecoration(
                                              'Senha de acesso', 'Digite sua senha'),
                                          onChanged: widget.presenter.validatePassword,
                                          */
                                        );
                                      }
                                    ),
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
                                    decoration:
                                        ThemeHelper().buttonBoxDecoration(context),
                                    child: StreamBuilder<bool>(
                                      stream: widget.presenter.isFormValidStream,
                                      builder: (context, snapshot) {
                                        return ElevatedButton(
                                          style: ThemeHelper().buttonStyle(),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(40, 10, 40, 10),
                                            child: Text(
                                              'Entrar'.toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          onPressed: snapshot.data == true ? widget.presenter.auth : null
                                          /*
                                          onPressed: () {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                          },
                                          */
                                        );
                                      }
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                    //child: Text('Don\'t have an account? Create'),
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(text: "Não tem uma conta? "),
                                      TextSpan(
                                        text: 'Criar ',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).accentColor),
                                      ),
                                    ])),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      })
    );
  }
}
