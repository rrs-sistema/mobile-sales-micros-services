import './../views_models/views_models.dart';

abstract class CategoriesPresenter {
  Stream<List<CategoryViewModel>?> get categoriesStream;  

   Future<void> loadData();
}