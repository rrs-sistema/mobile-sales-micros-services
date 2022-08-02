import './../../../../presentation/presenters/presenters.dart';
import './../../../../ui/pages/pages.dart';
import './../../factories.dart';

ProductsPresenter makeGetxBasePagePresenter() {
  return GetxProductsPresenter(
    loadProducts: makeRemoteLoadProductsWithLocalFallback(),
  );
}