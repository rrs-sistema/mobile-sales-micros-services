import 'package:get/get.dart';

import './../../domain/helpers/domain_error.dart';
import './../../ui/helpers/errors/errors.dart';
import './../../domain/usecases/usecases.dart';
import './../protocols/protocols.dart';
import './../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxSignUpPresenter extends GetxController with LoadingManager, NavigationManager, FormManager, UIErrorManager implements SignUpPresenter  {

  final Validation validation;
  final AddAccount addAccount;
  final SaveCurrentAccount saveCurrentAccount;

  var _emailError = Rx<UIError?>(null);
  var _nameError = Rx<UIError?>(null);
  var _passwordError = Rx<UIError?>(null);
  var _passwordConfirmationError = Rx<UIError?>(null);
  var _isAdminError = Rx<UIError?>(null);

  String? _name;
  String? _email;
  String? _password;
  String? _passwordConfirmation;
  bool _admin = false;

  Stream<UIError?> get emailErrorStream => _emailError.stream;
  Stream<UIError?> get nameErrorStream => _nameError.stream;
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;
  Stream<UIError?> get passwordConfirmationErrorStream => _passwordConfirmationError.stream;
  Stream<UIError?> get isAdminErrorStream => _isAdminError.stream;

  GetxSignUpPresenter({
      required this.validation, 
      required this.addAccount, 
      required this.saveCurrentAccount
    });

  void validateName(String name) {
    _name = name;
    _nameError.value = _validateField('name');
    _validateForm();
  }
  
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
 
  void validatePasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
    _passwordConfirmationError.value = _validateField('passwordConfirmation');
    _validateForm();
  }

  void validateAdmin(bool admin) {
    _admin = admin;
    _isAdminError.value = _validateField('admin');
    _validateForm();
  }

  UIError? _validateField(String field,) {
    final formData = {
      'name': _name,
      'email': _email,
      'password': _password,
      'passwordConfirmation': _passwordConfirmation,
      'admin': _admin
    };    
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.requiredField : return UIError.requiredField;
      case ValidationError.invalidField : return UIError.invalidField;
      default: return null;
    }
  }

  void _validateForm() {
    isFormValid = _nameError.value == null 
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
      isLoading = true;  
      mainError = null;
      final account = await addAccount.add(AddAccountParams(
        name: _name!, 
        email: _email!, 
        password: _password!, 
        passwordConfirmation: _passwordConfirmation!, 
        admin: _admin));
      await saveCurrentAccount.save(account);
      navigateTo = '/base_screen';
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.emailInUse : mainError = UIError.emailInUse;
          break;
        default: mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  void goToLogin() {
    navigateTo = '/login';
  }

}