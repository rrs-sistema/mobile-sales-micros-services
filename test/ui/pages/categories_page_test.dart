import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

import 'package:delivery_micros_services/ui/pages/categories/categories.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';

import './../helpers/helpers.dart';
import './../mocks/mosks.dart';

void main() {
  late CategoriesPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = CategoriesPresenterSpy();
    await tester.pumpWidget(makePage(path: '/categories', page: () => CategoriesPage(presenter)));
  }

  List<CategoryViewModel> makeCategories() => [
    CategoryViewModel(
      id: 1000,
      description: 'Bíblia',),
    CategoryViewModel(
      id: 1002,
      description: 'Tecnologia e Ciência',),          
  ];

  // Roda sempre no final dos testes
  tearDown(() {
    presenter.dispose();
  });

  testWidgets('Should call LoadCategories on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(() => presenter.loadData()).called(1);
  });
  
  testWidgets('Should present error if categoriesStream fails', (WidgetTester tester) async{
    await loadPage(tester);
    final circularProgressIndicator = find.byKey(ValueKey("circularLoadCategory"));
    expect(circularProgressIndicator, findsOneWidget);

    presenter.emiteCategoriesError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Bíblia'), findsNothing);
 
    expect(circularProgressIndicator, findsNothing);
  }); 
  
  testWidgets('Should present error if categoriesStream succeeds', (WidgetTester tester) async{
    await loadPage(tester);
    final circularProgressIndicator = find.byKey(ValueKey("circularLoadCategory"));
    expect(circularProgressIndicator, findsOneWidget);

    presenter.emiteCategories(makeCategories());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Bíblia'), findsOneWidget);
    expect(find.text('Tecnologia e Ciência'), findsOneWidget);
    expect(circularProgressIndicator, findsNothing);  
  }); 

  testWidgets('Should call LoadCategories on reload button click', (WidgetTester tester) async {
    await loadPage(tester);

    presenter.emiteCategoriesError(UIError.unexpected.description);
    await tester.pump();
    await tester.tap(find.text('Recarregar'));

    verify(() => presenter.loadData()).called(2);
  });

}
