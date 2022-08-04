import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/pages.dart';
import './../helpers/helpers.dart';

class SplashPresenterSpy extends Mock implements SplashPresenter {}

void main() {
  SplashPresenterSpy presenter;
  StreamController<String> navigateToStream;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    navigateToStream = StreamController<String>();
    when(presenter.navigateToStream)
        .thenAnswer((_) => navigateToStream.stream);
    await tester.pumpWidget(makePage(path: '/', page: () => SplashPage(presenter: presenter)));
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

    navigateToStream.add('/any_route');
    await tester.pumpAndSettle();

    expect(currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    navigateToStream.add('');
    await tester.pump();
    expect(currentRoute, '/');

    navigateToStream.add(null);
    await tester.pump();
    expect(currentRoute, '/');

  });

}
