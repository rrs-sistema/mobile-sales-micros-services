import 'package:meta/meta.dart';
import 'package:get/get.dart';

import './../../domain/helpers/domain_error.dart';
import './../../ui/helpers/errors/errors.dart';
import './../../domain/usecases/usecases.dart';
import './../protocols/protocols.dart';
import './../../ui/pages/pages.dart';

class GetxSignUpPresenter extends GetxController implements SignUpPresenter  {

  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  String _name;
  String _email;
  String _password;
  String _passwordConfirmation;
  bool _admin;

  var _emailError = Rx<UIError>();
  var _nameError = Rx<UIError>();
  var _passwordError = Rx<UIError>();
  var _passwordConfirmationError = Rx<UIError>();
  var _isAdminError = Rx<UIError>();
  var _mainError = Rx<UIError>();
  var _navigateTo = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  Stream<UIError> get emailErrorStream => _emailError.stream;
  Stream<UIError> get nameErrorStream => _nameError.stream;
  Stream<UIError> get passwordErrorStream => _passwordError.stream;
  Stream<UIError> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;
  
  Stream<UIError> get isAdminErrorStream => _isAdminError.stream;
  Stream<UIError> get mainErrorStream => _mainError.stream;

  Stream<String> get navigateToStream => _navigateTo.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxSignUpPresenter({
      @required this.validation, 
      @required this.addAccount, 
      @required this.saveCurrentAccount
    });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField(field: 'email', value: email);
    _validateForm();
  }

  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField(field: 'name', value: name);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField(field: 'password', value: password);
    _validateForm();
  }
 
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField(field: 'passwordConfirmation', value: passwordConfirmation);
    _validateForm();
  }

  void validateAdmin(bool admin) {
    _admin = admin;
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
    _isFormValid.value = _nameError.value == null 
      && _emailError.value == null 
      && _passwordError.value == null 
      && _passwordConfirmationError.value == null 
      && _name != null 
      && _email != null 
      && _password != null
      && _passwordConfirmation != null;     
  }
  
  Future<void> signUp() async {
    try {
      _isLoading.value = true;
      final account = await addAccount.add(AddAccountParams(
        name: _name, 
        email: _email, 
        password: _password, 
        passwordConfirmation: _passwordConfirmation, 
        admin: _admin));
      await saveCurrentAccount.save(account);
      _navigateTo.value = '/products';
    } on DomainError catch (error) {
      _mainError.value = null;
      switch (error) {
        case DomainError.emailInUse : _mainError.value = UIError.emailInUse;
          break;
        default: _mainError.value = UIError.unexpected;
          break;
      }
      _isLoading.value = false;
    }
  }

  void goToLogin() {
    _navigateTo.value = '/login';
  }

}