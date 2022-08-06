import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:delivery_micros_services/ui/helpers/helpers.dart';
import 'package:delivery_micros_services/ui/pages/pages.dart';
import './../helpers/helpers.dart';
import './../mocks/mosks.dart';

void main() {
  late  SignUpPresenterSpy presenter;
  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterSpy();
    await tester.pumpWidget(makePage(path: '/signup', page: () => SignUpPage(presenter)));
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should call validade with correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel('Nome de usuário '), name);
    verify(() => presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email de usuário '), email);
    verify(() => presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha de acesso '), password);
    verify(() => presenter.validatePassword(password));

    //final passwordConfirmation = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Confirmar senha '), password);
    verify(() => presenter.validatePasswordConfirmation(password));
  });

  testWidgets('Should presente name error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteNameError(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emiteNameError(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emiteNameValid();
    await tester.pump();
    expect(find.bySemanticsLabel('Nome de usuário '), findsOneWidget);
  });

  testWidgets('Should presente email error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteEmailError(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emiteEmailError(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emiteEmailValid();
    await tester.pump();
    expect(find.bySemanticsLabel('Email de usuário '), findsOneWidget);
  });

  testWidgets('Should presente password error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitePassworError(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emitePassworError(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emitePassworValid();
    await tester.pump();
    expect(find.bySemanticsLabel('Senha de acesso '), findsOneWidget);
  });

  testWidgets('Should presente passwordConfirmation error', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emitePassworConfirmationError(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    presenter.emitePassworConfirmationError(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    presenter.emitePassworConfirmationValid();
    await tester.pump();
    expect(find.bySemanticsLabel('Confirmar senha '), findsOneWidget);
  });

  testWidgets('Should enable button if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteFormValid();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('Should disable button if form is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteFormError();
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call signUp on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteFormValid();
    await tester.pump();
    final button = find.byType(ElevatedButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.signUp()).called(1);
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
  
  testWidgets('Should presente error message if signUp fails', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteMainError(UIError.emailInUse);
    await tester.pump();

    expect(find.text('Esse email já está em uso.'), findsOneWidget);
  });

  testWidgets('Should presente error message if signUp throws', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteMainError(UIError.unexpected);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'),
        findsOneWidget);
  });
  
  testWidgets('Should change page', (WidgetTester tester) async{
    await loadPage(tester);

    //navigateToController.add('/any_route');
    presenter.emiteNavigateTo('/any_route');
    await tester.pumpAndSettle();

    expect(currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  }); 

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteNavigateTo('');
    await tester.pump();
    expect(currentRoute, '/signup');

  });  

   testWidgets('Should call goToLogin on link click', (WidgetTester tester) async{
    await loadPage(tester);
    
    final button = find.byType(TextButton);
    await tester.ensureVisible(button);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.goToLogin()).called(1);
  });

}
