import 'package:get/get.dart';

import './../../../domain/helpers/domain_error.dart';
import './../../../domain/usecases/usecases.dart';
import './../../../domain/entities/entities.dart';
import './../../cache/cache.dart';
import './../../model/model.dart';

class LocalLoadCategories implements LoadCategories {
  final CacheStorage cacheStorage;

  LocalLoadCategories({required this.cacheStorage});

  final _navigateTo = RxString('');

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<List<CategoryEntity>> load() async {
    try {
      final data = await cacheStorage.fetch('categories');      
      if(data?.isEmpty != false) {
      throw Exception();
    }
      return _mapToEntity(data);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate() async {
    try {
      final data = await cacheStorage.fetch('categories');       
      _mapToEntity(data);
    } catch (error) {
      await cacheStorage.delete('categories'); 
    }
  }

  Future<void> save(List<CategoryEntity> categories) async {
    try {
      final dataMap = _mapToJson(categories);
      await cacheStorage.save(key: 'categories', value: dataMap);
    } catch(error) {
      throw DomainError.unexpected;
    }
  }

  List<CategoryEntity> _mapToEntity(dynamic list) =>
    list.map<CategoryEntity>((json) => LocalCategoryModel.fromJson(json).toEntity()).toList();

  List<Map> _mapToJson(List<CategoryEntity> list) =>
    list.map((entity) => LocalCategoryModel.fromEntity(entity).toJson()).toList();

}