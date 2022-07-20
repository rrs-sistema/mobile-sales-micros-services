import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main(){

  Future<void> loadPage(WidgetTester tester) async {
    final signPager = GetMaterialApp(
      initialRoute: '/signup',
      getPages: [
        GetPage(name: '/signup', page: () => SignUpPage()),
      ],
    );
    await tester.pumpWidget(signPager);
  }

  testWidgets('Should load with correct initial state', (WidgetTester tester) async{
    await loadPage(tester);

    final nameTextChildren = find.descendant(of: find.bySemanticsLabel('Nome de usuário '), matching: find.byType(Text));
    expect(nameTextChildren, findsOneWidget);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email de usuário '), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha de acesso '), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final passwordConfirmationTextChildren = find.descendant(of: find.bySemanticsLabel('Confirmar senha '), matching: find.byType(Text));
    expect(passwordConfirmationTextChildren, findsOneWidget);
    
    final adminSimCheckboxChildren = find.byKey(ValueKey('adminSim'));
    expect(adminSimCheckboxChildren, findsOneWidget);

    final adminNaoCheckboxChildren = find.byKey(ValueKey('adminNao'));
    expect(adminNaoCheckboxChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  
  });


}