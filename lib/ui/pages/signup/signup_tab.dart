import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './components/components.dart';
import './../../mixins/mixins.dart';
import './../../common/common.dart';
import './signup_presenter.dart';

class SignUpTab extends StatelessWidget with KeyboardManager, LoadingManager, UIErrorManager, NavigationManager  {
  final SignUpPresenter presenter;
  const SignUpTab(this.presenter);

  @override
  Widget build(BuildContext context) {
    Key _formKey = GlobalKey<FormState>();
    final primaryColor = ThemeHelper().makeAppTheme().primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Perfil do usuário'),
        actions: [
          IconButton(onPressed: () async {
            bool? result = await showLogoutConfirmation(context);
            if(result == true)
              presenter.logout();
          }, 
          icon: const Icon(Icons.logout))
        ],
      ),
      body: Builder(builder: (context) {
        handleLoading(context, presenter.isLoadingStream);
        handleMainError(context, presenter.mainErrorStream);
        handleNavigation(presenter.navigateToStream, clear: true);       
        return GestureDetector(
          onTap: () => hideKeyboard,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    margin: EdgeInsets.fromLTRB(
                        20, 10, 20, 10), // Este será o formulário de login
                    child: Column(
                      children: [
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

  Future<bool?> showLogoutConfirmation(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Confirmação'),
            content: const Text('Deseja realmente fazer logout?'),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop(false);
              }, child: const Text('Não')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Sim'))
            ],
          );
        });
  }

}
