abstract class LoginPresenter {

  Stream get emailErroStream;
  Stream get passwordErroStream;
  void validateEmail(String email);
  void validatePassword(String password);
  
}