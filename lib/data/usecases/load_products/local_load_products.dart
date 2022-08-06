import './../../../domain/usecases/usecases.dart';
import './../../../domain/entities/entities.dart';
import './../../../domain/helpers/helpers.dart';
import './../../cache/cache.dart';
import './../../model/model.dart';

class LocalLoadProducts implements LoadProducts {
  final CacheStorage cacheStorage;

  LocalLoadProducts({required this.cacheStorage});

  Future<ProductEntity> loadById(int id) async {
    try {
      final data = await cacheStorage.fetch(id.toString());      
      if(data?.isEmpty != false) {
      throw Exception();
    }
      return _mapToEntityOne(data);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

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
      for (var product in products) {
        await saveOne(product);
      }
    } catch(error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> saveOne(ProductEntity product) async {
    try {
      final dataMap = _mapToJsonOne(product);
      await cacheStorage.save(key: product.id.toString(), value: dataMap);
    } catch(error) {
      throw DomainError.unexpected;
    }
  }

  ProductEntity _mapToEntityOne(dynamic json) =>
    LocalProductModel.fromJson(json).toEntity();

  Map _mapToJsonOne(ProductEntity entity) =>
    LocalProductModel.fromEntity(entity).toJson();


  List<ProductEntity> _mapToEntity(dynamic list) =>
    list.map<ProductEntity>((json) => LocalProductModel.fromJson(json).toEntity()).toList();

  List<Map> _mapToJson(List<ProductEntity> list) =>
    list.map((entity) => LocalProductModel.fromEntity(entity).toJson()).toList();

}