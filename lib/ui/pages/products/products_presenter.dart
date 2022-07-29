import './product_view_model.dart';

abstract class ProductsPresenter {
  Stream<List<ProductViewModel>> get productsStream;  

   Future<void> loadData();
}