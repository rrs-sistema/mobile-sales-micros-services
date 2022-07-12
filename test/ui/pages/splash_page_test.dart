import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/pages.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {}

void main() {
  SplashPresenterSpy presenter;
  StreamController<String> navigateToStream;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    navigateToStream = StreamController<String>();
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToStream.stream);

    await tester.pumpWidget(GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '', page: () => SplashPage(presenter: presenter)),
        GetPage(
            name: '/any_router',
            page: () => Scaffold(
                  body: Text('fake page'),
                ))
      ],
    ));
  }

  tearDown(() {
    navigateToStream.close();
  });

  testWidgets('Should present spinner on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load',
      (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.checkAccount()).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToStream.add('/any_router');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_router');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToStream.add('');
    await tester.pump();
    expect(Get.currentRoute, '/');

    navigateToStream.add(null);
    await tester.pump();
    expect(Get.currentRoute, '/');

  });

}
