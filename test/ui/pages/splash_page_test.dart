import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import 'package:delivery_micros_services/ui/pages/pages.dart';

import './../helpers/helpers.dart';
import './../mocks/mosks.dart';

void main() {
  late SplashPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = SplashPresenterSpy();
    await tester.pumpWidget(makePage(path: '/', page: () => SplashPage(presenter: presenter)));
  }

  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should present spinner on page load', (WidgetTester tester) async {
    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.checkAccount()).called(1);
  });

  testWidgets('Should change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteNavigateTo('/any_route');
    await tester.pumpAndSettle();

    expect(currentRoute, '/any_route');
    expect(find.text('fake page'), findsOneWidget);
  });

  testWidgets('Should not change page', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteNavigateTo('');
    await tester.pump();
    expect(currentRoute, '/');
  });

}
