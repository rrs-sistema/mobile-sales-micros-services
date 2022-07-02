import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';

import 'package:delivery_micros_services/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main(){
  LoginPresenter presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    final loginPager = MaterialApp(home: LoginPage(presenter: presenter,),);
    await tester.pumpWidget(loginPager);
  }

  testWidgets('Should load with correct initial state', (WidgetTester tester) async{
    await loadPage(tester);

    final emailTextChildren = find.bySemanticsLabel('Email de usuário');
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.bySemanticsLabel('Senha de acesso');
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

}