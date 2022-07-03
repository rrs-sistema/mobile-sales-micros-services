abstract class LoginPresenter {

  Stream get emailErroStream;
  Stream get passwordErroStream;
  Stream get isFormValidStream;
  
  void validateEmail(String email);
  void validatePassword(String password);
  
}