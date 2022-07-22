import './strings.dart';

class PtBr implements Translations {
  String get msgEmailInUse => 'Esse email já está em uso.';
  String get msgInvalidField => 'Campo inválido';
  String get msgInvalidCredentials => 'Credenciais inválidas.';
  String get msgRequiredFiel => 'Campo obrigatório';
  String get msgUnexpectedError => 'Algo errado aconteceu. Tente novamente em breve.';

  String get acceptanceTerm => 'Aceito todos os termos e condições. '; 
  String get accessPassword => 'Senha de acesso ';
  String get addAccount => 'Criar conta ';
  String get alreadyHaveAnAccount => 'já tem uma conta? ';
  String get confirmPassword => 'Confirmar senha ';
  String get createAnAccoun => 'Crie uma conta agora '; 
  String get createAccountWithSocial => 'Ou crie uma conta usando as redes sociais ';
  String get dontHaveAnAccount => 'Não tem uma conta ';
  String get forgotYourPassword => 'Esqueceu sua senha? ';
  String get typeYourPassword => 'Digite sua senha ';
  String get logIn => 'Entrar ';
  String get loginToYourAccount => 'Fazer login na sua conta ';
  String get typeYourEmail => 'Digite seu email ';
  String get userEmail => 'Email de usuário ';
  String get userName => 'Nome de usuário ';
}