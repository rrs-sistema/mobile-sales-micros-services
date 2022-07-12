import './strings.dart';

class EnUs implements Translations {
  String get msgRequiredFiel => 'Required field ';
  String get msgInvalidField => 'Invalid field ';
  String get msgInvalidCredentials => 'Invalid credentials. ';
  String get msgErrorDefault => 'Something went wrong. Please try again soon. ';

  String get addAccount => 'Add account ';
  String get accessPassword => 'Access password ';
  String get dontHaveAnAccount => "Don't have an account ";
  String get forgotYourPassword => 'Forgot your password? ';
  String get logIn => 'Log in ';
  String get loginToYourAccount => 'Login to your account ';
  String get typeYourEmail => 'Type your e-mail ';
  String get typeYourPassword => 'Type your password ';
  String get userEmail => 'User email ';
}