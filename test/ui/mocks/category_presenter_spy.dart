import 'package:mocktail/mocktail.dart';
import 'dart:async';

import 'package:delivery_micros_services/ui/pages/pages.dart';

class CategoriesPresenterSpy extends Mock implements CategoriesPresenter {
  final categoriesController = StreamController<List<CategoryViewModel>>();

  CategoriesPresenterSpy() {
    when(() => this.loadData()).thenAnswer((_) async => _);
    when(() => this.categoriesStream).thenAnswer((_) => categoriesController.stream);
  } 

  void emiteCategories(List<CategoryViewModel> data) => categoriesController.add(data);
  void emiteCategoriesError(String error) => categoriesController.addError(error);

  void dispose(){
    categoriesController.close();
  }

}