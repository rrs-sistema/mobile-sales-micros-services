import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/helpers/helpers.dart';
import 'package:delivery_micros_services/ui/pages/pages.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {}

void main() {
  SignUpPresenter presenter;

  StreamController<UIError> passwordConfirmationErrorController;
  StreamController<UIError> passwordErrorController;
  StreamController<UIError> emailErrorController;
  StreamController<UIError> nameErrorController;
  StreamController<UIError> mainErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;
  StreamController<String> navigateToController;

  void initStreams() {
    passwordConfirmationErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    emailErrorController = StreamController<UIError>();
    nameErrorController = StreamController<UIError>();
    mainErrorController = StreamController<UIError>();
    navigateToController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
  }

  void mockStreams() {
    when(presenter.passwordConfirmationErrorStream)
        .thenAnswer((_) => passwordConfirmationErrorController.stream);
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.nameErrorStream)
        .thenAnswer((_) => nameErrorController.stream);
    when(presenter.mainErrorStream)
        .thenAnswer((_) => mainErrorController.stream);
    when(presenter.navigateToStream).thenAnswer((_) => navigateToController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);
  }

  void closeStreams() {
    passwordConfirmationErrorController.close();
    passwordErrorController.close();
    emailErrorController.close();
    nameErrorController.close();
    mainErrorController.close();
    navigateToController.close();
    isFormValidController.close();
    isLoadingController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterSpy();
    initStreams();
    mockStreams();
    final signPager = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage(presenter)),
        GetPage(name: '/any_route', page: () => Scaffold(body: Text('fake page'),)),
      ],
    );
    await tester.pumpWidget(signPager);
  }

  // Roda sempre no final dos testes
  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call validade with correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel('Nome de usu??rio '), name);
    verify(presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email de usu??rio '), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha de acesso '), password);
    verify(presenter.validatePassword(password));

    //final passwordConfirmation = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Confirmar senha '), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

  testWidgets('Should presente name error', (WidgetTester tester) async {
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inv??lido'), findsOneWidget);

    nameErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigat??rio'), findsOneWidget);

    nameErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Nome de usu??rio '), findsOneWidget);
  });

  testWidgets('Should presente email error', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inv??lido'), findsOneWidget);

    emailErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigat??rio'), findsOneWidget);

    emailErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Email de usu??rio '), findsOneWidget);
  });

  testWidgets('Should presente password error', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inv??lido'), findsOneWidget);

    passwordErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigat??rio'), findsOneWidget);

    passwordErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Senha de acesso '), findsOneWidget);
  });

  testWidgets('Should presente passwordConfirmation error', (WidgetTester tester) async {
    await loadPage(tester);

    passwordConfirmationErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inv??lido'), findsOneWidget);

    passwordConfirmationErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigat??rio'), findsOneWidget);

    passwordConfirmationErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Confirmar senha '), findsOneWidget);
  });

  testWidgets('Should enable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call signUp on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(presenter.signUp()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async{
    await loadPage(tester);

   final circularProgressIndicator = find.byKey(ValueKey("circularProgressIndicatorShowLoading"));

    isLoadingController.add(true);
    await tester.pump();
    expect(circularProgressIndicator, findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(circularProgressIndicator, findsNothing);    

    isLoadingController.add(true);
    await tester.pump();
    expect(circularProgressIndicator, findsOneWidget);
    
    isLoadingController.add(null);
    await tester.pump();
    expect(circularProgressIndicator, findsNothing);       
  }); 
  
  testWidgets('Should presente error message if signUp fails', (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.emailInUse);
    await tester.pump();

    expect(find.text('Esse email j?? est?? em uso.'), findsOneWidget);
  });

  testWidgets('Should presente error message if signUp throws', (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add(UIError.unexpected);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
  });
  
  testWidgets('Should change page', (WidgetTester tester) async{
    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();// Espera a anima????o acontecer

    expect(Get.currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  }); 

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, '/signup');

    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/signup');

  });  

   testWidgets('Should call goToLogin on link click', (WidgetTester tester) async{
    await loadPage(tester);
    
    final button = find.byType(TextButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(presenter.goToLogin()).called(1);
  });

}
