import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/base_screen/base_screen.dart';
import 'package:delivery_micros_services/ui/helpers/services/services.dart';
import 'package:delivery_micros_services/ui/pages/products/products.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';

class ProductsPresenterSpy extends Mock implements ProductsPresenter {}

void main() {
  ProductsPresenterSpy presenter;
  StreamController<bool> isLoadingController;
  StreamController<List<ProductViewModel>> productsController;

  void initStreams() {
    isLoadingController = StreamController<bool>();   
    productsController =  StreamController<List<ProductViewModel>>();
  }
  
  void mockStreams() {
    when(presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);  
    when(presenter.productsStream).thenAnswer((_) => productsController.stream); 
  }  

  void closeStreams(){
    isLoadingController.close();
    productsController.close();
  }

  Future<void> loadPage(WidgetTester tester) async {
    presenter = ProductsPresenterSpy();
    initStreams();
    mockStreams();

    final basePageScreen = GetMaterialApp(
      initialRoute: '/base_screen',
      getPages: [
        GetPage(
          name: '/base_screen',
          page: () => BasePageScreen(presenter,)),
      ],
    );
    await tester.pumpWidget(basePageScreen);
  }

  List<ProductViewModel> makeProducts() => [
    ProductViewModel(
      id: 1002,
      name: 'Bíblia atualizada',
      description: 'Bíblia atualizada de Almeida e Corrigida',
      imgUrl: faker.image.image(),
      quantityAvailable: 8,
      createdAt: DateTime.parse('2022-07-28 03:11:46'),
      price: 92.28,
      supplier: SupplierViewModel(id: 1000, name: 'Sociedade Bíblica do Brasil'),
      category: CategoryViewModel(id: 1000, description: 'Bíblia')),
    ProductViewModel(
      id: 1002,
      name: 'Bíblia Pentecostal',
      description: 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
      imgUrl: faker.image.image(),
      quantityAvailable: 8,
      createdAt: DateTime.parse('2022-07-28 08:15:32'),
      price: 135.98,
      supplier: SupplierViewModel(id: 1000, name: 'Sociedade Bíblica do Brasil'),
      category: CategoryViewModel(id: 1000, description: 'Bíblia'))           
  ];

  // Roda sempre no final dos testes
  tearDown(() {
    closeStreams();
  });

  testWidgets('Should call LoadProducts on page load', (WidgetTester tester) async {
    await loadPage(tester);

    verify(presenter.loadData()).called(1);
  });

  testWidgets('Should handle loading correctly', (WidgetTester tester) async{
    await loadPage(tester);

   final circularProgressIndicator = find.byKey(ValueKey("circularProgressIndicatorShowLoading"));

    isLoadingController.add(true);
    await tester.pump();
    expect(circularProgressIndicator, findsOneWidget);

    isLoadingController.add(false);
    await tester.pump();
    expect(circularProgressIndicator, findsNothing);    

    isLoadingController.add(true);
    await tester.pump();
    expect(circularProgressIndicator, findsOneWidget);

    isLoadingController.add(null);
    await tester.pump();
    expect(circularProgressIndicator, findsNothing);       
  }); 
  
  testWidgets('Should present error if productsStream fails', (WidgetTester tester) async{
    await loadPage(tester);

    productsController.addError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Bíblia'), findsNothing);
  }); 
  
  testWidgets('Should present error if productsStream succeeds', (WidgetTester tester) async{
    await loadPage(tester);

    productsController.add(makeProducts());
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsNothing);
    expect(find.text('Recarregar'), findsNothing);
    expect(find.text('Bíblia atualizada'), findsOneWidget);
    expect(find.text('Bíblia Pentecostal'), findsOneWidget);
    expect(find.text(UtilsServices().priceToCurrency(92.28)), findsOneWidget);
    expect(find.text(UtilsServices().priceToCurrency(135.98)), findsOneWidget);    
  }); 

  testWidgets('Should call LoadProducts on reload button click', (WidgetTester tester) async {
    await loadPage(tester);

    productsController.addError(UIError.unexpected.description);
    await tester.pump();
    await tester.tap(find.text('Recarregar'));

    verify(presenter.loadData()).called(2);
  });

}
