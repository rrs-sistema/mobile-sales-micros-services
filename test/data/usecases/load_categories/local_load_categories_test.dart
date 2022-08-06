import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';

import '../../mocks/mocks.dart';

void main() {
  late LocalLoadCategories sut;
  late CacheStorageSpy cacheStorage;
  late List<Map<String, dynamic>> data;
  late List<CategoryEntity> categories;

  List<Map<String, dynamic>> mockValidData() => [
    {"id": '1000', "description": "Bíblia",},
    {"id": '1002', "description": "Comentário",},
  ];

  List<CategoryEntity> mockCategories() => [
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
    categories = mockCategories();
    data = mockValidData();
    cacheStorage.mockFetch(data);
    sut = LocalLoadCategories(cacheStorage: cacheStorage);

  });

  group('load', () {

    test('Should call CacheStorage whith correct key', () async {
      await sut.load();

      verify(() => cacheStorage.fetch('categories')).called(1);
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
      cacheStorage.mockFetch([{}]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is null', () async {
      cacheStorage.mockFetch([{}]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is isvalid', () async {
      cacheStorage.mockFetch([
        {
          "id": 'invalid id',
          'description': 'Comentário',
        },
      ]);

      final future = sut.load();

      expect(future, throwsA(DomainError.unexpected));
    });

    test('Should throw UnexpectedError if cache is incomplete', () async {
      cacheStorage.mockFetch([
        {
          'id': '1002',
        },
      ]);

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

    setUp(() {
      cacheStorage.mockFetch(mockValidData());
    });

    test('Should call CacheStorage whith correct key', () async {
      await sut.validate();

      verify(() => cacheStorage.fetch('categories')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      cacheStorage.mockFetch([
        {"id": 1000, "description": "Bíblia"},
        {"id": 1002, "description": "Comentário"},
      ]);

      await sut.validate();

      verify(() => cacheStorage.delete('categories')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      cacheStorage.mockFetch([
        {"id": 1000, "description": "Bíblia"},
        {"id": 1002, "description": "Comentário"},
      ]);

      await sut.validate();

      verify(() => cacheStorage.delete('categories')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      cacheStorage.mockFetchError();

      await sut.validate();

      verify(() => cacheStorage.delete('categories')).called(1);
    });
  });

  group('save', () {
    test('Should call CacheStorage whith correct values', () async {
      await sut.save(categories);

      verify(() => cacheStorage.save(key: 'categories', value: data)).called(1);
    });

    test('Should throw UnexpectedError if save throws', () async {
      cacheStorage.mockSaveError();

      final future = sut.save(categories);

      expect(future, throwsA(DomainError.unexpected));
    });
  });

}
