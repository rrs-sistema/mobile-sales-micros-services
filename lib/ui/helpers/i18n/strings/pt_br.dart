import './strings.dart';

class PtBr implements Translations {
  String get msgRequiredFiel => 'Campo obrigatório';
  String get msgInvalidField => 'Campo inválido';
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  String get msgErrorDefault => 'Algo errado aconteceu. Tente novamente em breve.';

  String get addAccount => 'Criar conta ';
  String get accessPassword => 'Senha de acesso ';
  String get dontHaveAnAccount => 'Não tem uma conta ';
  String get forgotYourPassword => 'Esqueceu sua senha? ';
  String get typeYourPassword => 'Digite sua senha ';
  String get logIn => 'Entrar ';
  String get loginToYourAccount => 'Fazer login na sua conta ';
  String get typeYourEmail => 'Digite seu email ';
  String get userEmail => 'Email de usuário ';
}