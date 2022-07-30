import '../../../../presentation/presenters/presenters.dart';
import '../../../../main/factories/usecases/usecases.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

CategoriesPresenter makeGetxCategoriesPresenter() => GetxCategoriesPresenter(
  loadCategories: makeRemoteLoadCategories(),
);