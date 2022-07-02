abstract class LoginPresenter {

  Stream get emailErroStream;
  void validateEmail(String email);
  void validatePassword(String password);
  
}