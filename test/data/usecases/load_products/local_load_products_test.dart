import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';

import './../../../infra/mocks/cache_factory.dart';
import './../../../domain/mocks/mocks.dart';
import './../../mocks/mocks.dart';

void main() {
  late LocalLoadProducts sut;
  late CacheStorageSpy cacheStorage;
  late List<Map> data;
  late List<ProductEntity> products;

  setUp(() {
    cacheStorage = CacheStorageSpy();

    data = CacheFactory.makeProducts();
    products = EntityFactory.makeProductList();
    sut = LocalLoadProducts(cacheStorage: cacheStorage);
    cacheStorage.mockFetch(data);
  });
    
  group('load', () {
    test('Should call CacheStorage whith correct key', () async {
      await sut.load();

      verify(() => cacheStorage.fetch('products')).called(1);
    });

    test('Should return a list of products on success', () async {
      final products = await sut.load();

      expect(products, EntityFactory.makeCacheJsonToListProductEntity());
    });

    test('Should throw UnexpectedError if cache is empty', () async {
      cacheStorage.mockFetch([{}]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is isvalid', () async {
      cacheStorage.mockFetch(CacheFactory.makeInvalidCacheJson());

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      cacheStorage.mockFetch(CacheFactory.makeIncompleteCacheJson());

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is error', () async {
      cacheStorage.mockFetchError();

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });
  });

  group('validate', () {

    test('Should call CacheStorage whith correct key', () async {
      await sut.validate();

      verify(() => cacheStorage.fetch('products')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      cacheStorage.mockFetch(CacheFactory.makeInvalidCacheJson());

      await sut.validate();

      verify(() => cacheStorage.delete('products')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      cacheStorage.mockFetch(CacheFactory.makeIncompleteCacheJson());

      await sut.validate();

      verify(() => cacheStorage.delete('products')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      cacheStorage.mockFetchError();

      await sut.validate();

      verify(() => cacheStorage.delete('products')).called(1);
    });
  });

  group('save', () {
    test('Should call CacheStorage whith correct values', () async {
      final List<Map<String, dynamic>> list = CacheFactory.makeSaveCacheJson();

      await sut.save(products);

      verify(() => cacheStorage.save(key: 'products', value: list)).called(1);
    });

    test('Should throw UnexpectedError if save throws', () async {
      cacheStorage.mockSaveError();

      final future = sut.save(products);

      expect(future, throwsA(DomainError.unexpected));
    });
  });
}
