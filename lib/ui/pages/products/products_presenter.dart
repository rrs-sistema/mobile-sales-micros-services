import './products.dart';

abstract class ProductsPresenter {
  Stream<List<ProductViewModel>> get productsStream;  

   Future<void> loadData();
}