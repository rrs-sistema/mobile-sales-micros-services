import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/categories/categories.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';

class CategoriesPresenterSpy extends Mock implements CategoriesPresenter {}

void main() {
  CategoriesPresenterSpy presenter;
  StreamController<List<CategoryViewModel>> categoriesController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = CategoriesPresenterSpy();
    categoriesController =  StreamController<List<CategoryViewModel>>();
    when(presenter.categoriesStream).thenAnswer((_) => categoriesController.stream);

    final basePageScreen = GetMaterialApp(
      initialRoute: '/categories',
      getPages: [
        GetPage(
          name: '/categories',
          page: () => CategoriesPage(presenter)),
      ],
    );
    await tester.pumpWidget(basePageScreen);
  }

  List<CategoryViewModel> makeCategories() => [
    CategoryViewModel(
      id: 1000,
      description: 'Bíblia',),
    CategoryViewModel(
      id: 1003,
      description: 'Tecnologia e Ciência',),          
  ];

  // Roda sempre no final dos testes
  tearDown(() {
    categoriesController.close();
  });

  testWidgets('Should call LoadCategories on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });
  
  testWidgets('Should present error if categoriesStream fails', (WidgetTester tester) async{
    await loadPage(tester);
    final circularProgressIndicator = find.byKey(ValueKey("circularLoadCategory"));
    expect(circularProgressIndicator, findsOneWidget);

    categoriesController.addError(UIError.unexpected.description);
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

    categoriesController.add(makeCategories());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Bíblia'), findsOneWidget);
    expect(find.text('Tecnologia e Ciência'), findsOneWidget);
    expect(circularProgressIndicator, findsNothing);  
  }); 

  testWidgets('Should call LoadCategories on reload button click', (WidgetTester tester) async {
    await loadPage(tester);

    categoriesController.addError(UIError.unexpected.description);
    await tester.pump();
    await tester.tap(find.text('Recarregar'));

    verify(presenter.loadData()).called(2);
  });

}
