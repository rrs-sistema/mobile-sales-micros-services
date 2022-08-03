import './../../../../presentation/presenters/presenters.dart';
import './../../../../ui/pages/pages.dart';
import './../../factories.dart';

CategoriesPresenter makeGetxCategoriesPresenter() {
  return GetxCategoriesPresenter(
    loadCategories: makeRemoteLoadCategoriesWithLocalFallback()
  );
}