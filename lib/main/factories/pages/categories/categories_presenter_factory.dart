import 'package:delivery_micros_services/main/factories/usecases/load_categories_factory.dart';
import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

CategoriesPresenter makeGetxCategoriesPresenter() => GetxCategoriesPresenter(
  loadCategories: makeRemoteLoadCategories(),
);