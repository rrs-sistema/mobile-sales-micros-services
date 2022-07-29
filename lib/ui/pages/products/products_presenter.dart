import './product_view_model.dart';

abstract class ProductsPresenter {
  Stream<bool> get isLoadingStream;
  Stream<List<ProductViewModel>> get loadProductsStream;  

   Future<void> loadData();
}