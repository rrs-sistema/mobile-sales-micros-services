import './products.dart';

abstract class ProductsPresenter {
  Stream<List<ProductViewModel>?> get productsStream;  
  Stream<ProductViewModel?> get productStream;  
  Stream<bool> get isSessionExpiredStream;  
  Stream<String?> get navigateToStream;  

  Future<void> loadData();
  Future<void> loadById(int id);
  void goToDetailResult(int productId);
}