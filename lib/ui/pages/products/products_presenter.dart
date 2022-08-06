import './products.dart';

abstract class ProductsPresenter {
  Stream<List<ProductViewModel>?> get productsStream;  
  Stream<bool> get isSessionExpiredStream;  
  Stream<String?> get navigateToStream;  

  Future<void> loadData();
  void goToDetailResult(int productId);
}