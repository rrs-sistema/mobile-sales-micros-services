import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';
import 'package:delivery_micros_services/ui/pages/pages.dart';

import './../helpers/helpers.dart';
import './../mocks/mosks.dart';

void main() {
  late  LoginPresenterSpy presenter;
  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    await tester.pumpWidget(makePage(path: '/login', page: () => LoginPage(presenter)));
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should call validade with correct values', (WidgetTester tester) async{
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email de usuário '), email);
    verify(() => presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha de acesso '), password);
    verify(() => presenter.validatePassword(password));
  });

  testWidgets('Should presente error if email is invalid', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteEmailError(UIError.invalidField);
    await tester.pump(); 

    expect(find.text('Campo inválido'), findsOneWidget);
  });  

  testWidgets('Should presente error if email is empty', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteEmailError(UIError.requiredField);
    await tester.pump(); 

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });  

  testWidgets('Should presente error if email is valid', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteEmailValid();
    await tester.pump(); 

    expect(find.text('Email de usuário '), findsOneWidget);
  }); 

  testWidgets('Should presente error if password is empty', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emitePassworError(UIError.requiredField);
    await tester.pump(); 

    expect(find.text('Campo obrigatório'), findsOneWidget);
  });

  testWidgets('Should presente error if email is valid', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emitePassworValid();
    await tester.pump(); 

    expect(find.text('Senha de acesso '), findsOneWidget);
  }); 

  testWidgets('Should enable button if form is valid', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteFormValid();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  }); 

  testWidgets('Should disable button if form is invalid', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteFormError();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  }); 

  testWidgets('Should call autentication on form submit', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteFormValid();
    await tester.pump();
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.auth()).called(1);
  }); 
  
  testWidgets('Should handle loading correctly', (WidgetTester tester) async{
    await loadPage(tester);

   final circularProgressIndicator = find.byKey(ValueKey("circularProgressIndicatorShowLoading"));

    presenter.emiteLoading();
    await tester.pump();
    expect(circularProgressIndicator, findsOneWidget);

    presenter.emiteLoading(false);
    await tester.pump();
    expect(circularProgressIndicator, findsNothing);    

    presenter.emiteLoading();
    await tester.pump();
    expect(circularProgressIndicator, findsOneWidget);    
  }); 
  
  testWidgets('Should presente error message if authentication fails', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteMainError(UIError.invalidCredentials);
    await tester.pump();

    expect(find.text('Credenciais inválidas.'), findsOneWidget);
  });

  testWidgets('Should presente error message if authentication throws', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteMainError(UIError.unexpected);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsOneWidget);
  });

  testWidgets('Should change page', (WidgetTester tester) async{
    await loadPage(tester);

    presenter.emiteNavigateTo('/any_route');
    await tester.pumpAndSettle();// Espera a animação acontecer

    expect(currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  }); 

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteNavigateTo('');
    await tester.pump();
    expect(currentRoute, '/login');
  });  

   testWidgets('Should call goToSignUp on link click', (WidgetTester tester) async{
    await loadPage(tester);
    
    final button = find.byType(TextButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.goToSignUp()).called(1);
  });

}