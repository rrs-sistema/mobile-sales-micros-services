import 'package:mocktail/mocktail.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/pages.dart';

class ProductsPresenterSpy extends Mock implements ProductsPresenter {
  final productsController = StreamController<List<ProductViewModel>>();
  final navigateToController = StreamController<String?>();
  final isSessionExpiredController = StreamController<bool>();  

  ProductsPresenterSpy() {
    when(() => this.loadData()).thenAnswer((_) async => _);
    when(() => this.isSessionExpiredStream).thenAnswer((_) => isSessionExpiredController.stream);
    when(() => this.productsStream).thenAnswer((_) => productsController.stream);
    when(() => this.navigateToStream).thenAnswer((_) => navigateToController.stream);    
  } 

  void emiteProducts(List<ProductViewModel> data) => productsController.add(data);
  void emiteProductsError(String error) => productsController.addError(error);
  void emiteSessionExpired([bool show = true]) => isSessionExpiredController.add(show);
  void emiteNavigateTo(String route) => navigateToController.add(route);

  void dispose(){
    isSessionExpiredController.close();
    productsController.close();
    navigateToController.close();
  }

}