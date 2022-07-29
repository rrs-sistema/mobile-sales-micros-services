import './views_models/views_models.dart';

abstract class ProductsPresenter {
  Stream<List<ProductViewModel>> get productsStream;  

   Future<void> loadData();
}