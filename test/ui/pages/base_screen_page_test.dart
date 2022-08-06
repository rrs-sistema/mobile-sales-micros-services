import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import 'package:delivery_micros_services/ui/pages/base_screen/base_screen.dart';
import 'package:delivery_micros_services/ui/helpers/services/services.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';

import './../model/mocks/mocks.dart';
import './../helpers/helpers.dart';
import './../mocks/mosks.dart';

void main() {
  late ProductsPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = ProductsPresenterSpy();
    await tester.pumpWidget(makePage(path: '/base_screen', page: () => BasePageScreen(presenter)));
  }

  // Roda sempre no final dos testes
  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should call LoadProducts on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.loadData()).called(1);
  });

  testWidgets('Should present error if productsStream fails', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteProductsError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Question 1'), findsNothing);
  });

  testWidgets('Should present list if productsStream succeeds', (WidgetTester tester) async {
    await loadPage(tester);
    final circularProgressIndicator = find.byKey(ValueKey("circularLoadProduct"));
    expect(circularProgressIndicator, findsOneWidget);

    presenter.emiteProducts(ModelFactory.makeViewModel());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Bíblia atualizada'), findsOneWidget);
    expect(find.text('Bíblia Pentecostal'), findsOneWidget);
    expect(find.text(UtilsServices().priceToCurrency(92.28)), findsOneWidget);
    expect(find.text(UtilsServices().priceToCurrency(135.98)), findsOneWidget); 
    expect(circularProgressIndicator, findsNothing);     
  });

  testWidgets('Should call LoadProducts on reload button click', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteProductsError(UIError.unexpected.description);
    await tester.pump();
    await tester.tap(find.text('Recarregar'));

    verify(() => presenter.loadData()).called(2);
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
    expect(currentRoute, '/base_screen');
  });

  testWidgets('Should logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteSessionExpired();
    
    await tester.pumpAndSettle();

    expect(currentRoute, '/login');
    expect(find.text('fake login'), findsOneWidget);
  });

  testWidgets('Should not logout', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteSessionExpired(false);
    await tester.pump();
    expect(currentRoute, '/base_screen');
  });  
  /*
  testWidgets('Should call goToDetailResult on product click', (WidgetTester tester) async {
    await loadPage(tester);

    productsController.add(FakeProductsFactory.makeViewModel());
    await tester.pump();

    await tester.tap(find.text('Bíblia atualizada'));    
    await tester.pump();

    verify(() => presenter.goToDetailResult(1002)).called(1);
  });
  */

}
