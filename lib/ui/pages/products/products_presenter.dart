abstract class ProductsPresenter {
  Stream<bool> get isLoadingStream;

   Future<void> loadData();
}