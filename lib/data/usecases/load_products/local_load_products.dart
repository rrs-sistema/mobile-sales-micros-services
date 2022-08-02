import 'package:meta/meta.dart';
import 'package:get/get.dart';

import './../../../domain/helpers/domain_error.dart';
import './../../../domain/usecases/usecases.dart';
import './../../../domain/entities/entities.dart';
import './../../cache/cache.dart';
import './../../model/model.dart';

class LocalLoadProducts implements LoadProducts {
  final CacheStorage cacheStorage;

  LocalLoadProducts({@required this.cacheStorage});

  final _navigateTo = RxString();

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<List<ProductEntity>> load() async {
    try {
      final data = await cacheStorage.fetch('products');      
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
      final data = await cacheStorage.fetch('products');       
      _mapToEntity(data);
    } catch (error) {
      await cacheStorage.delete('products'); 
    }
  }

  Future<void> save(List<ProductEntity> products) async {
    try {
      final dataMap = _mapToJson(products);
      await cacheStorage.save(key: 'products', value: dataMap);
    } catch(error) {
      throw DomainError.unexpected;
    }
  }

  List<ProductEntity> _mapToEntity(dynamic list) =>
    list.map<ProductEntity>((json) => LocalProductModel.fromJson(json).toEntity()).toList();

  List<Map> _mapToJson(List<ProductEntity> list) =>
    list.map((entity) => LocalProductModel.fromEntity(entity).toJson()).toList();

}