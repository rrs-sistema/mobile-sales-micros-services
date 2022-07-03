import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';

import 'package:delivery_micros_services/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main(){
  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<bool> isFormValidController;
  
  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();

    emailErrorController = StreamController<String>();
    when(presenter.emailErroStream).thenAnswer((_) => emailErrorController.stream);

    passwordErrorController = StreamController<String>();
    when(presenter.passwordErroStream).thenAnswer((_) => passwordErrorController.stream);

    isFormValidController = StreamController<bool>();
    when(presenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);

    final loginPager = MaterialApp(home: LoginPage(presenter: presenter,),);
    await tester.pumpWidget(loginPager);
  }

  // Roda sempre no final dos testes
  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
  });

  testWidgets('Should load with correct initial state', (WidgetTester tester) async{
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email de usuário'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha de acesso'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call validade with correct values', (WidgetTester tester) async{
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email de usuário'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha de acesso'), password);
    verify(presenter.validatePassword(password));
  });

  testWidgets('Should presente error if email is invalid', (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add('any erro');
    await tester.pump(); // Força um render nos componentes para ser renderizados

    expect(find.text('any erro'), findsOneWidget);
  });  

  testWidgets('Should presente no error if email is valid', (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    expect(find.bySemanticsLabel('Email de usuário'), findsOneWidget);
  });    

  testWidgets('Should presente no error if email is valid', (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add('');
    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('Email de usuário'), matching: find.byType(Text)), findsOneWidget);
  });  

  testWidgets('Should presente error if password is invalid', (WidgetTester tester) async{
    await loadPage(tester);

    passwordErrorController.add('any erro');
    await tester.pump(); // Força um render nos componentes para ser renderizados

    expect(find.text('any erro'), findsOneWidget);
  });

  testWidgets('Should presente no error if password is valid', (WidgetTester tester) async{
    await loadPage(tester);

   passwordErrorController.add(null);
    await tester.pump();

    expect(find.bySemanticsLabel('Senha de acesso'), findsOneWidget);
  });    

  testWidgets('Should presente no error if password is valid', (WidgetTester tester) async{
    await loadPage(tester);

    passwordErrorController.add('');
    await tester.pump();

    expect(find.descendant(of: find.bySemanticsLabel('Senha de acesso'), matching: find.byType(Text)), findsOneWidget);
  }); 

  testWidgets('Should enable button if form is valid', (WidgetTester tester) async{
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  }); 

  testWidgets('Should enable button if form is valid', (WidgetTester tester) async{
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  }); 

  testWidgets('Should call autentication on form submit', (WidgetTester tester) async{
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(presenter.auth()).called(1);
  }); 

}