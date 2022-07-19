import 'package:get/get.dart';
import 'package:meta/meta.dart';

import './../../domain/helpers/domain_error.dart';
import './../../domain/usecases/usecases.dart';
import './../../ui/helpers/errors/errors.dart';
import './../protocols/protocols.dart';
import './../../ui/pages/pages.dart';


class GetxLoginPresenter extends GetxController implements LoginPresenter {

  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;
  var _emailError = Rx<UIError>();
  var _passwordError = Rx<UIError>();
  var _mainError = Rx<UIError>();
  var _navigateToStream = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get mainErrorStream => _mainError.stream;
  Stream<String> get navigateToStream => _navigateToStream.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({@required this.validation, @required this.authentication, this.saveCurrentAccount});

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }

  UIError _validateField({String field, String value}) {
    final error = validation.validate(field: field, value: value);
    switch (error) {
      case ValidationError.requiredField : return UIError.requiredField;
        break;
      case ValidationError.invalidField : return UIError.invalidField;
        break;        
      default: return null;
    }
  }

  void _validateForm() {
    _isFormValid.value = _emailError.value == null 
      && _passwordError.value == null 
      && _email != null 
      && _password != null;    
  }

  Future<void> auth() async {
    try {
     _isLoading.value = true;      
      final account = await authentication.auth(AuthenticationParams(email: _email, secret: _password));
      await saveCurrentAccount.save(account);
      _navigateToStream.value = '/products';
    } on DomainError catch (error) {
      _mainError.value = null;
      switch (error) {
        case DomainError.invalidCredentials : _mainError.value = UIError.invalidCredentials;
          break;
        default: _mainError.value = UIError.unexpected;
      }
      _isLoading.value = false;
    }
  }

  // ignore: must_call_super
  void dispose() {}
  
}