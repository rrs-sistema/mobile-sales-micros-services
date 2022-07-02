import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:delivery_micros_services/ui/pages/pages.dart';

void main(){
  testWidgets('Should load with correct initial state', (WidgetTester tester) async{
    final loginPager = MaterialApp(home: LoginPage(),);
    await tester.pumpWidget(loginPager);
    
    final emailTextChildren = find.bySemanticsLabel('Email de usuário');
    expect(emailTextChildren, findsOneWidget);

    final passwordTextChildren = find.bySemanticsLabel('Senha de acesso');
    expect(passwordTextChildren, findsOneWidget);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);

  });
}