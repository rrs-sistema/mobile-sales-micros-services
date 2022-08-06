import 'package:mocktail/mocktail.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';
import 'package:delivery_micros_services/ui/pages/pages.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final passwordConfirmationController = StreamController<UIError?>();
  final passwordErrorController = StreamController<UIError?>();
  final nameErrorController = StreamController<UIError?>();
  final emailErrorController = StreamController<UIError?>();
  final mainErrorController = StreamController<UIError?>();
  final navigateToController = StreamController<String?>();
  final isFormValidController = StreamController<bool>();
  final isLoadingController = StreamController<bool>();  

  SignUpPresenterSpy() {
    when(() => this.signUp()).thenAnswer((_) async => _);
    when(() => this.nameErrorStream).thenAnswer((_) => nameErrorController.stream);
    when(() => this.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => this.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => this.passwordConfirmationErrorStream).thenAnswer((_) => passwordConfirmationController.stream);
    when(() => this.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => this.navigateToStream).thenAnswer((_) => navigateToController.stream);
    when(() => this.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(() => this.isLoadingStream).thenAnswer((_) => isLoadingController.stream); 
  } 

  void emiteNameError(UIError error) => nameErrorController.add(error);
  void emiteNameValid() => nameErrorController.add(null);

  void emiteEmailError(UIError error) => emailErrorController.add(error);
  void emiteEmailValid() => emailErrorController.add(null);

  void emitePassworError(UIError error) => passwordErrorController.add(error);
  void emitePassworValid() => passwordErrorController.add(null);

  void emitePassworConfirmationError(UIError error) => passwordErrorController.add(error);
  void emitePassworConfirmationValid() => passwordErrorController.add(null);

  void emiteFormError() => isFormValidController.add(false);
  void emiteFormValid() => isFormValidController.add(true);

  void emiteLoading([bool show = true]) => isLoadingController.add(show);

  void emiteMainError(UIError error) => mainErrorController.add(error);
  void emiteNavigateTo(String route) => navigateToController.add(route);

  void dispose(){
    nameErrorController.close();
    emailErrorController.close();
    passwordErrorController.close();
    passwordConfirmationController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();   
    navigateToController.close();  
  }

}
