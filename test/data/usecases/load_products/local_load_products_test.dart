import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/cache/cache.dart';

import '../../../mocks/mocks.dart';

class CacheStorageSpy extends Mock implements CacheStorage {}

void main() {
  group('load', () {
    LocalLoadProducts sut;
      CacheStorageSpy cacheStorage;
      List<Map> data;

      PostExpectation  mockFetchAll() => when(cacheStorage.fetch(any));

      void mockFetch(List<Map> list) {
        data = list;
        mockFetchAll().thenAnswer((_) async => data);
      }

      void mockFetchError() => mockFetchAll().thenThrow(Exception());
      
      setUp(() {
        cacheStorage = CacheStorageSpy();
        sut = LocalLoadProducts(cacheStorage: cacheStorage);
        mockFetch(FakeProductsFactory.makeCacheJson());
      });

      test('Should call CacheStorage whith correct key', () async {
        await sut.load();

        verify(cacheStorage.fetch('products')).called(1);
      });

      test('Should return a list of products on success', () async {
        final products = await sut.load();

        expect(products, FakeProductsFactory.makeCacheJsonToListProductEntity());
      });

      test('Should throw UnexpectedError if cache is empty', () async {
        mockFetch([]);

        final future = sut.load();

        expect(future, throwsA(DomainError.unexpected));
      });

      test('Should throw UnexpectedError if cache is null', () async {
        mockFetch(null);

        final future = sut.load();

        expect(future, throwsA(DomainError.unexpected));
      });

      test('Should throw UnexpectedError if cache is isvalid', () async {
        mockFetch(FakeProductsFactory.makeInvalidCacheJson());

        final future = sut.load();

        expect(future, throwsA(DomainError.unexpected));
      });

      test('Should throw UnexpectedError if cache is incomplete', () async {
        mockFetch(FakeProductsFactory.makeIncompleteCacheJson());

        final future = sut.load();

        expect(future, throwsA(DomainError.unexpected));
      });

      test('Should throw UnexpectedError if cache is error', () async {
        mockFetchError();

        final future = sut.load();

        expect(future, throwsA(DomainError.unexpected));
      });

  });

  group('validate', () {
    LocalLoadProducts sut;
    CacheStorageSpy cacheStorage;
    List<Map> data;

    PostExpectation  mockFetchAll() => when(cacheStorage.fetch(any));

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchAll().thenAnswer((_) async => data);
    }
    
    void mockFetchError() => mockFetchAll().thenThrow(Exception());

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadProducts(cacheStorage: cacheStorage);
      mockFetch(FakeProductsFactory.makeCacheJson());
    });

    test('Should call CacheStorage whith correct key', () async {
      await sut.validate();

      verify(cacheStorage.fetch('products')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      mockFetch(FakeProductsFactory.makeInvalidCacheJson());

      await sut.validate();

      verify(cacheStorage.delete('products')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      mockFetch(FakeProductsFactory.makeIncompleteCacheJson());

      await sut.validate();

      verify(cacheStorage.delete('products')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      mockFetchError();

      await sut.validate();

      verify(cacheStorage.delete('products')).called(1);
    });

  });

  group('save', () {
    LocalLoadProducts sut;
    CacheStorageSpy cacheStorage;
    List<ProductEntity> products;

    PostExpectation  mockFetchAll() => when(cacheStorage.save(key: anyNamed('key'), value: anyNamed('value')));
    
    void mockSaveError() => mockFetchAll().thenThrow(Exception());

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadProducts(cacheStorage: cacheStorage);
      products = FakeProductsFactory.makeEntities();
    });

    test('Should call CacheStorage whith correct values', () async {
      final List<Map<String, dynamic>> list = FakeProductsFactory.makeSaveCacheJson();

      await sut.save(products);

      verify(cacheStorage.save(key: 'products', value: list)).called(1);
    });
    
    test('Should throw UnexpectedError if save throws', () async {
      mockSaveError();

      final future = sut.save(products);

      expect(future, throwsA(DomainError.unexpected));
    });    

  });

}
