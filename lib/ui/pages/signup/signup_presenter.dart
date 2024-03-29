import './../../helpers/errors/errors.dart';

abstract class SignUpPresenter {
  Stream<UIError?> get nameErrorStream;
  Stream<UIError?> get emailErrorStream;
  Stream<UIError?> get passwordErrorStream;
  Stream<UIError?> get passwordConfirmationErrorStream;
  Stream<UIError?> get isAdminErrorStream;

  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  
  Stream<UIError?> get mainErrorStream;
  Stream<String?> get navigateToStream;

  void validateName(String name);
  void validateEmail(String email);
  void validatePassword(String password);
  void validatePasswordConfirmation(String passwordConfirmation);  
  void validateAdmin(bool admin);  
  Future<void> signUp();
  Future<void> logout();  
  void goToLogin();
}