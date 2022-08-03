import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/cache/cache.dart';

class CacheStorageSpy extends Mock implements CacheStorage {}

void main() {
  group('load', () {
    LocalLoadCategories sut;
    CacheStorageSpy cacheStorage;
    List<Map> data;

    List<Map> mockValidData() => [
          {"id": '1000', "description": "Bíblia"},
          {"id": '1002', "description": "Comentário"},
        ];

    PostExpectation mockFetchAll() => when(cacheStorage.fetch(any));

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchAll().thenAnswer((_) async => data);
    }

    void mockFetchError() => mockFetchAll().thenThrow(Exception());

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadCategories(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test('Should call CacheStorage whith correct key', () async {
      await sut.load();

      verify(cacheStorage.fetch('categories')).called(1);
    });

    test('Should return a list of categories on success', () async {
      final categories = await sut.load();

      expect(categories, [
        CategoryEntity(
          id: int.parse(data[0]['id']),
          description: data[0]['description'],
        ),
        CategoryEntity(
          id: int.parse(data[1]['id']),
          description: data[1]['description'],
        )
      ]);
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
      mockFetch([
        {
          "id": 'invalid id',
          'description': 'Comentário',
        },
      ]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      mockFetch([
        {
          'id': '1002',
        },
      ]);

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
    LocalLoadCategories sut;
    CacheStorageSpy cacheStorage;
    List<Map> data;

    List<Map> mockValidData() => [
          {
            'id': '1000',
            'description': 'Bíblia',
          },
          {
            'id': '1002',
            'description': 'Comentário',
          }
        ];

    PostExpectation mockFetchAll() => when(cacheStorage.fetch(any));

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchAll().thenAnswer((_) async => data);
    }

    void mockFetchError() => mockFetchAll().thenThrow(Exception());

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadCategories(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test('Should call CacheStorage whith correct key', () async {
      await sut.validate();

      verify(cacheStorage.fetch('categories')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      mockFetch([
        {"id": 1000, "description": "Bíblia"},
        {"id": 1002, "description": "Comentário"},
      ]);

      await sut.validate();

      verify(cacheStorage.delete('categories')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      mockFetch([
        {"id": 1000, "description": "Bíblia"},
        {"id": 1002, "description": "Comentário"},
      ]);

      await sut.validate();

      verify(cacheStorage.delete('categories')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      mockFetchError();

      await sut.validate();

      verify(cacheStorage.delete('categories')).called(1);
    });
  });

  group('save', () {
    LocalLoadCategories sut;
    CacheStorageSpy cacheStorage;
    List<CategoryEntity> categories;

    PostExpectation mockFetchAll() =>
        when(cacheStorage.save(key: anyNamed('key'), value: anyNamed('value')));

    void mockSaveError() => mockFetchAll().thenThrow(Exception());

    List<CategoryEntity> mockProducts() => [
          CategoryEntity(
            id: 1000,
            description: 'Bíblia',
          ),
          CategoryEntity(
            id: 1002,
            description: 'Comentário',
          ),
        ];

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadCategories(cacheStorage: cacheStorage);
      categories = mockProducts();
    });

    test('Should call CacheStorage whith correct values', () async {
      final List<Map<String, dynamic>> list = [
        {
          "id": "1000",
          "description": "Bíblia",
        },
        {
          "id": "1002",
          "description": "Comentário",
        }
      ];

      await sut.save(categories);

      verify(cacheStorage.save(key: 'categories', value: list)).called(1);
    });

    test('Should throw UnexpectedError if save throws', () async {
      mockSaveError();

      final future = sut.save(categories);

      expect(future, throwsA(DomainError.unexpected));
    });
  });

}
