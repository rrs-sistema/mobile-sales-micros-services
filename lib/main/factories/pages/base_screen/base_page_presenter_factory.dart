import './../../../../presentation/presenters/presenters.dart';
import './../../../../main/factories/factories.dart';
import './../../../../ui/pages/pages.dart';

ProductsPresenter makeGetxBasePagePresenter() {
  return GetxProductsPresenter(
    loadProducts: makeRemoteLoadProducts()
  );
}