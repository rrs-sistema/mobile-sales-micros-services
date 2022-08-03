import 'package:meta/meta.dart';
import 'package:get/get.dart';

import './../../domain/helpers/domain_error.dart';
import './../../domain/usecases/usecases.dart';
import './../../ui/helpers/errors/errors.dart';
import './../protocols/protocols.dart';
import './../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxLoginPresenter extends GetxController with LoadingManager, NavigationManager, FormManager, UIErrorManager implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;
  
  final _emailError = Rx<UIError>();
  final _passwordError = Rx<UIError>();
  
  String _email;
  String _password;

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;

  GetxLoginPresenter({
    @required this.validation,
    @required this.authentication,
    @required this.saveCurrentAccount
  });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
    };
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField: return UIError.invalidField;
      case ValidationError.requiredField: return UIError.requiredField;
      default: return null;
    }
  }

  void _validateForm() {
    isFormValid = _emailError.value == null
      && _passwordError.value == null
      && _email != null
      && _password != null;
  }

  Future<void> auth() async {
    try {
      isLoading = true;
      mainError = null;
      final account = await authentication.auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccount.save(account);
      navigateTo = '/base_screen';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials: mainError = UIError.invalidCredentials; break;
        default: mainError = UIError.unexpected; break;
      }
      isLoading = false;
    }
  }

  void goToSignUp() {
    navigateTo = '/signup';
  }
  
}