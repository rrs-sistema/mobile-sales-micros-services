import '../entities/entities.dart';

abstract class LoadCategories {
  Future<List<CategoryEntity>> load();
}