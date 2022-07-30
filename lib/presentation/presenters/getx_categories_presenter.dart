import 'package:meta/meta.dart';
import 'package:get/get.dart';

import './../../domain/usecases/usecases.dart';
import './../../domain/helpers/helpers.dart';
import './../../ui/helpers/helpers.dart';
import './../../ui/pages/pages.dart';

class GetxCategoriesPresenter implements CategoriesPresenter {
  final LoadCategories loadCategories;

  final _categories = Rx<List<CategoryViewModel>>();

  Stream<List<CategoryViewModel>> get categoriesStream => _categories.stream;

  GetxCategoriesPresenter({@required this.loadCategories});

  Future<void> loadData() async {
    try {
      final categories = await loadCategories.load();
      _categories.value = categories
          .map((product) => CategoryViewModel(
                id: product.id,
                description: product.description,
              ))
          .toList();
    } on DomainError {
      _categories.addError(UIError.unexpected.description, StackTrace.empty);
    }
  }

}