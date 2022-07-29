import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/base_screen/base_screen.dart';
import 'package:delivery_micros_services/ui/pages/products/products.dart';
import 'package:delivery_micros_services/ui/helpers/errors/errors.dart';

class ProductsPresenterSpy extends Mock implements ProductsPresenter {}

void main() {
  ProductsPresenterSpy presenter;
  StreamController<bool> isLoadingController;
  StreamController<List<ProductViewModel>> loadProductsController;

  void initStreams() {
    isLoadingController = StreamController<bool>();   
    loadProductsController =  StreamController<List<ProductViewModel>>();
  }
  
  void mockStreams() {
    when(presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);  
    when(presenter.loadProductsStream).thenAnswer((_) => loadProductsController.stream); 
  }  

  void closeStreams(){
    isLoadingController.close();
    loadProductsController.close();
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
  
  testWidgets('Should present error if loadProductsStream fails', (WidgetTester tester) async{
    await loadPage(tester);

    loadProductsController.addError(UIError.unexpected.description);
    await tester.pump();

    expect(find.text('Algo errado aconteceu. Tente novamente em breve.'), findsOneWidget);
    expect(find.text('Recarregar'), findsOneWidget);
    expect(find.text('Bíblia'), findsNothing);
  }); 
  
}
