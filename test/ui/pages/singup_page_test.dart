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

  void initStreams() {
    passwordConfirmationErrorController = StreamController<UIError>();
    passwordErrorController = StreamController<UIError>();
    emailErrorController = StreamController<UIError>();
    nameErrorController = StreamController<UIError>();
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
  }

  void closeStreams() {
    passwordConfirmationErrorController.close();
    passwordErrorController.close();
    emailErrorController.close();
    nameErrorController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SignUpPresenterSpy();
    initStreams();
    mockStreams();
    final signPager = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage(presenter)),
      ],
    );
    await tester.pumpWidget(signPager);
  }

  // Roda sempre no final dos testes
  tearDown(() {
    closeStreams();
  });

  testWidgets('Should load with correct initial state',
      (WidgetTester tester) async {
    await loadPage(tester);

    final nameTextChildren = find.descendant(
        of: find.bySemanticsLabel('Nome de usuário '),
        matching: find.byType(Text));
    expect(nameTextChildren, findsOneWidget);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email de usuário '),
        matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha de acesso '),
        matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final passwordConfirmationTextChildren = find.descendant(
        of: find.bySemanticsLabel('Confirmar senha '),
        matching: find.byType(Text));
    expect(passwordConfirmationTextChildren, findsOneWidget);

    final adminSimCheckboxChildren = find.byKey(ValueKey('adminSim'));
    expect(adminSimCheckboxChildren, findsOneWidget);

    final adminNaoCheckboxChildren = find.byKey(ValueKey('adminNao'));
    expect(adminNaoCheckboxChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should call validade with correct values',
      (WidgetTester tester) async {
    await loadPage(tester);

    final name = faker.person.name();
    await tester.enterText(find.bySemanticsLabel('Nome de usuário '), name);
    verify(presenter.validateName(name));

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email de usuário '), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha de acesso '), password);
    verify(presenter.validatePassword(password));

    //final passwordConfirmation = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Confirmar senha '), password);
    verify(presenter.validatePasswordConfirmation(password));
  });

  testWidgets('Should presente name error', (WidgetTester tester) async{
    await loadPage(tester);

    nameErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    nameErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    nameErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Nome de usuário '), findsOneWidget);
  });  

  testWidgets('Should presente email error', (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    emailErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    emailErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Email de usuário '), findsOneWidget);
  });

  testWidgets('Should presente password error', (WidgetTester tester) async{
    await loadPage(tester);

    passwordErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    passwordErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    passwordErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Senha de acesso '), findsOneWidget);
  });

  testWidgets('Should presente passwordConfirmation error', (WidgetTester tester) async{
    await loadPage(tester);

    passwordConfirmationErrorController.add(UIError.invalidField);
    await tester.pump();
    expect(find.text('Campo inválido'), findsOneWidget);

    passwordConfirmationErrorController.add(UIError.requiredField);
    await tester.pump();
    expect(find.text('Campo obrigatório'), findsOneWidget);

    passwordConfirmationErrorController.add(null);
    await tester.pump();
    expect(find.bySemanticsLabel('Confirmar senha '), findsOneWidget);
  });

}
