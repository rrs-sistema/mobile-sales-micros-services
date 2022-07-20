import './../../helpers/errors/errors.dart';

abstract class SignUpPresenter {

  Stream<UIError> get nameErrorStream;
  Stream<UIError> get emailErrorStream;
  Stream<UIError> get passwordErrorStream;
  Stream<UIError> get passwordConfirmationErrorStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String password);    
  /*
  Stream<UIError> get mainErrorStream;
  Stream<String> get navigateToStream;
  
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  Future<void> auth();
  void dispose();
  */
}