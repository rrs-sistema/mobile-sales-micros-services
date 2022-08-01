import 'package:meta/meta.dart';

import './../../../domain/helpers/domain_error.dart';
import './../../../domain/usecases/usecases.dart';
import './../../../domain/entities/entities.dart';
import './../../cache/cache.dart';
import './../../model/model.dart';

class LocalLoadProducts implements LoadProducts {
  final CacheStorage cacheStorage;

  LocalLoadProducts({@required this.cacheStorage});

  Future<List<ProductEntity>> load() async {
    try {
      final data = await cacheStorage.fetch('products');      
      if(data?.isEmpty != false) {
      throw Exception();
    }
      return data.map<ProductEntity>((json) => LocalProductModel.fromJson(json).toEntity()).toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Future<void> validate() async {
    try {
      final data = await cacheStorage.fetch('products');  
      data.map<ProductEntity>((json) => LocalProductModel.fromJson(json).toEntity()).toList();
    } catch (error) {
      await cacheStorage.delete('products'); 
    }
  }

}