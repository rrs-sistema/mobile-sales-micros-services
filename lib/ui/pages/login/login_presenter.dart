abstract class LoginPresenter {

  Stream<String> get emailErroStream;
  Stream<String> get passwordErroStream;
  Stream<String> get mainErrorStream;
  
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void auth();
  
}