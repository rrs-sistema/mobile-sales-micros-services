import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/cache/cache.dart';
import 'package:delivery_micros_services/data/model/model.dart';

class CacheStorageSpy extends Mock implements CacheStorage {}

void main() {
  group('load', () {
    LocalLoadProducts sut;
      CacheStorageSpy cacheStorage;
      final imgUrl001 = faker.image.image();
      final imgUrl002 = faker.image.image();
      List<Map> data;

      List<Map> mockValidData() => [
          {
            'id': '1002',
            'name': 'Bíblia atualizada',
            'description': 'Bíblia atualizada de Almeida e Corrigida',
            'quantityAvailable': '8',
            'createdAt': '01/08/2022 12:00:00',
            "price": '92.28',
            'imgUrl': imgUrl001,
            "supplier": {
              "id": '1000',
              "name": 'Sociedade Bíblica do Brasil',
            },
            "category": {
              "id": '1000',
              "description": 'Bíblia',
            },
          },
          {
            'id': '1002',
            'name': 'Bíblia Pentecostal',
            'description': 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
            'quantityAvailable': '8',
            'createdAt': '28/07/2022 08:15:32',
            "price": '135.98',
            'imgUrl': imgUrl002,
            "supplier": {
              "id": '1000',
              "name": 'Sociedade Bíblica do Brasil',
            },
            "category": {
              "id": '1000',
              "description": 'Bíblia',
            },
          }
        ];

      PostExpectation  mockFetchAll() => when(cacheStorage.fetch(any));

      void mockFetch(List<Map> list) {
        data = list;
        mockFetchAll().thenAnswer((_) async => data);
      }

      void mockFetchError() => mockFetchAll().thenThrow(Exception());
      
      setUp(() {
        cacheStorage = CacheStorageSpy();
        sut = LocalLoadProducts(cacheStorage: cacheStorage);
        mockFetch(mockValidData());
      });

      test('Should call CacheStorage whith correct key', () async {
        await sut.load();

        verify(cacheStorage.fetch('products')).called(1);
      });

      test('Should return a list of products on success', () async {
        final products = await sut.load();

        expect(products, [
          ProductEntity(
              id: int.parse(data[0]['id']),
              name: data[0]['name'],
              description: data[0]['description'],
              imgUrl: data[0]['imgUrl'],
              quantityAvailable: int.parse(data[0]['quantityAvailable']),
              createdAt: data[0]['createdAt'],
              price: double.parse(data[0]['price']),
              supplier: LocalSupplierModel.fromJson(data[0]['supplier']).toEntity(),
              category: LocalCategoryModel.fromJson(data[0]['category']).toEntity()),
          ProductEntity(
              id: int.parse(data[1]['id']),
              name: data[1]['name'],
              description: data[1]['description'],
              imgUrl: data[1]['imgUrl'],
              quantityAvailable: int.parse(data[1]['quantityAvailable']),
              createdAt: data[1]['createdAt'],
              price: double.parse(data[1]['price']),
              supplier: LocalSupplierModel.fromJson(data[1]['supplier']).toEntity(),
              category: LocalCategoryModel.fromJson(data[1]['category']).toEntity())
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
            'name': 'Bíblia atualizada',
            'description': 'Bíblia atualizada de Almeida e Corrigida',
            "quantityAvailable": 'invalid price',
            'createdAt': '01/08/2022 12:00:00',
            "price": 'invalid price',
            'imgUrl': imgUrl001,
            "supplier": {
              "id": '1000',
              "name": 'Sociedade Bíblica do Brasil',
            },
            "category": {
              "id": '1000',
              "description": 'Bíblia',
            },
          },
        ]);

        final future = sut.load();

        expect(future, throwsA(DomainError.unexpected));
      });

      test('Should throw UnexpectedError if cache is incomplete', () async {
        mockFetch([
          {
            'id': '1002',
            'name': 'Bíblia atualizada',
            'description': 'Bíblia atualizada de Almeida e Corrigida',
            'quantityAvailable': '8',
            'createdAt': '01/08/2022 12:00:00',
            "price": '92.28',
            'imgUrl': imgUrl001,
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
    LocalLoadProducts sut;
    CacheStorageSpy cacheStorage;
    final imgUrl001 = faker.image.image();
    final imgUrl002 = faker.image.image();
    List<Map> data;

    List<Map> mockValidData() => [
        {
          'id': '1002',
          'name': 'Bíblia atualizada',
          'description': 'Bíblia atualizada de Almeida e Corrigida',
          'quantityAvailable': '8',
          'createdAt': '01/08/2022 12:00:00',
          "price": '92.28',
          'imgUrl': imgUrl001,
          "supplier": {
            "id": '1000',
            "name": 'Sociedade Bíblica do Brasil',
          },
          "category": {
            "id": '1000',
            "description": 'Bíblia',
          },
        },
        {
          'id': '1002',
          'name': 'Bíblia Pentecostal',
          'description': 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
          'quantityAvailable': '8',
          'createdAt': '28/07/2022 08:15:32',
          "price": '135.98',
          'imgUrl': imgUrl002,
          "supplier": {
            "id": '1000',
            "name": 'Sociedade Bíblica do Brasil',
          },
          "category": {
            "id": '1000',
            "description": 'Bíblia',
          },
        }
      ];

    PostExpectation  mockFetchAll() => when(cacheStorage.fetch(any));

    void mockFetch(List<Map> list) {
      data = list;
      mockFetchAll().thenAnswer((_) async => data);
    }
    
    void mockFetchError() => mockFetchAll().thenThrow(Exception());

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadProducts(cacheStorage: cacheStorage);
      mockFetch(mockValidData());
    });

    test('Should call CacheStorage whith correct key', () async {
      await sut.validate();

      verify(cacheStorage.fetch('products')).called(1);
    });

    test('Should delete cache if it is invalid', () async {
      mockFetch([
        {
          'id': '1002',
          'name': 'Bíblia atualizada',
          'description': 'Bíblia atualizada de Almeida e Corrigida',
          'created_at': 'invalid created_at',
          "supplier": {
            "id": '1000',
            "name": 'Sociedade Bíblica do Brasil',
          },
          "category": {
            "id": '1000',
            "description": 'Bíblia',
          },
        },
      ]);

      await sut.validate();

      verify(cacheStorage.delete('products')).called(1);
    });

    test('Should delete cache if it is incomplete', () async {
      mockFetch([
        {
          'id': '1002',
          'name': 'Bíblia atualizada',
          'description': 'Bíblia atualizada de Almeida e Corrigida',
          'quantityAvailable': '8',
          'createdAt': '01/08/2022 12:00:00',
          "price": '92.28',
        },
      ]);

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
    final imgUrl001 = faker.image.image();
    final imgUrl002 = faker.image.image();

    PostExpectation  mockFetchAll() => when(cacheStorage.save(key: anyNamed('key'), value: anyNamed('value')));
    
    void mockSaveError() => mockFetchAll().thenThrow(Exception());

    List<ProductEntity> mockProducts() => [
      ProductEntity(
          id: 1002,
          name: 'Bíblia atualizada',
          description: 'Bíblia atualizada de Almeida e Corrigida',
          imgUrl: imgUrl001,
          quantityAvailable: 8,
          createdAt: '01/08/2022 12:00:00',
          price: 92.28,
          supplier: SupplierEntity(id: 1000, name: 'Sociedade Bíblica do Brasil'),
          category: CategoryEntity(id: 1000, description: 'Bíblia'),),
      ProductEntity(
          id: 1003,
          name: 'Bíblia Pentecostal',
          description: 'Bíblia Pentecostal atualizada de Almeida e Corrigida',
          imgUrl: imgUrl002,
          quantityAvailable: 6,
          createdAt: '28/07/2022 08:15:32',
          price: 135.98,
          supplier: SupplierEntity(id: 1000, name: 'Sociedade Bíblica do Brasil'),
          category: CategoryEntity(id: 1000, description: 'Bíblia')),          
    ];

    setUp(() {
      cacheStorage = CacheStorageSpy();
      sut = LocalLoadProducts(cacheStorage: cacheStorage);
      products = mockProducts();
    });

    test('Should call CacheStorage whith correct values', () async {
      final List<Map<String, dynamic>> list = [{
        "id": "1002",
        "name": "Bíblia atualizada",
        "description": "Bíblia atualizada de Almeida e Corrigida",
        "imgUrl": imgUrl001,
        "quantityAvailable": "8",
        "createdAt": "01/08/2022 12:00:00",
        "price": "92.28",
        "category": {
          "id": "1000",
          "description": "Bíblia",
        },        
        "supplier": {
          "id": "1000",
          "name": "Sociedade Bíblica do Brasil",
        },
      },
        {
          "id": "1003",
          "name": "Bíblia Pentecostal",
          "description": "Bíblia Pentecostal atualizada de Almeida e Corrigida",
          "imgUrl": imgUrl002,          
          "quantityAvailable": "6",
          "createdAt": "28/07/2022 08:15:32",
          "price": "135.98",
          "category": {
            "id": "1000",
            "description": "Bíblia",
          },          
          "supplier": {
            "id": "1000",
            "name": "Sociedade Bíblica do Brasil",
          },
        }
      ];

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
