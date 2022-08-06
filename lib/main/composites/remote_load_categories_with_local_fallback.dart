import 'package:get/get.dart';

import './../../domain/entities/entities.dart';
import './../../domain/usecases/usecases.dart';
import './../../domain/helpers/helpers.dart';
import './../../data/usecases/usecases.dart';

class RemoteLoadCategoriesWithLocalFallback implements LoadCategories {
  final RemoteLoadCategories remote;
  final LocalLoadCategories local;

  RemoteLoadCategoriesWithLocalFallback({
    required this.remote,
    required this.local
  });

  final _navigateTo = RxString('');

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<List<CategoryEntity>> load() async {
    try {
      final categories = await remote.load();
      await local.save(categories);
      return categories;
    } catch(error) {
      if (error == DomainError.accessDenied) {
        _navigateTo.value = '/login';
        rethrow;
      }
      await local.validate();
      return await local.load();
    }
  }
}