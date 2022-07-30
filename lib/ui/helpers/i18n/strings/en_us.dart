import './strings.dart';

class EnUs implements Translations {
  String get msgEmailInUse => 'This email is already in use.';
  String get msgInvalidField => 'Invalid field ';
  String get msgInvalidCredentials => 'Invalid credentials. ';
  String get msgRequiredFiel => 'Required field ';
  String get msgUnexpectedError => 'Something went wrong. Please try again soon. ';
  
  String get acceptanceTerm => 'I accept all terms and conditions. '; //Aceito todos os termos e condições.
  String get accessPassword => 'Access password ';// Senha de acesso
  String get addAccount => 'Add account ';// Adicionar Conta
  String get alreadyHaveAnAccount => 'Already have an account? '; // já tem uma conta?
  String get confirmPassword => 'Confirm password '; // Confirmar senha
  String get createAnAccoun => 'Create an account now '; // Crie uma conta agora
  String get createAccountWithSocial => 'Or create an account using social networks ';// Ou crie uma conta usando as redes sociais
  String get dontHaveAnAccount => "Don't have an account "; // Não tem uma conta?
  String get forgotYourPassword => 'Forgot your password? '; // já tem uma conta?
  String get logIn => 'Log in ';// Conecte-se
  String get loginToYourAccount => 'Login to your account '; // Faça login na sua conta
  String get reload => 'Reload'; // Recarregar
  String get typeYourEmail => 'Type your e-mail '; // Digite seu email
  String get typeYourPassword => 'Type your password '; // Digite sua senha
  String get userEmail => 'User email '; // E-mail do usuário
  String get userName => 'User name '; // Nome do usuário

  String get titleAppName => 'Delivery Library Services';
  String get titleCategorie => 'Category';
  String get titleNavBarHome => 'Home';
  String get titleNavBarCarrinho => 'Cart';
  String get titleNavBarPedido => 'Shopping';
  String get titleNavBarPerfil => 'Profile';
}