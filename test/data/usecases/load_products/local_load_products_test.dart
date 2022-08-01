import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/helpers/domain_error.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/cache/cache.dart';
import 'package:delivery_micros_services/data/model/model.dart';

class LocalLoadProducts {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadProducts({@required this.fetchCacheStorage});

  Future<List<ProductEntity>> load() async {
    try {
      final data = await fetchCacheStorage.fetch('products');      
      if(data?.isEmpty != false) {
      throw Exception();
    }
      return data.map<ProductEntity>((json) => LocalProductModel.fromJson(json).toEntity()).toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}

class FetchCacheStorageSpy extends Mock implements FetchCacheStorage {}

void main() {
  LocalLoadProducts sut;
  FetchCacheStorageSpy fetchCacheStorage;
  final imgUrl001 = faker.image.image();
  final imgUrl002 = faker.image.image();
  List<Map> data;

  List<Map> mockValidData() => [
      {
        'id': '1002',
        'name': 'Bíblia atualizada',
        'description': 'Bíblia atualizada de Almeida e Corrigida',
        'quantity_available': '8',
        'created_at': '01/08/2022 12:00:00',
        "price": '92.28',
        'img_url': imgUrl001,
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
        'quantity_available': '8',
        'created_at': '28/07/2022 08:15:32',
        "price": '135.98',
        'img_url': imgUrl002,
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

  PostExpectation  mockFetchAll() => when(fetchCacheStorage.fetch(any));

  void mockFetch(List<Map> list) {
    data = list;
    mockFetchAll().thenAnswer((_) async => data);
  }

  void mockFetchError() => mockFetchAll().thenThrow(Exception());
  
  setUp(() {
    fetchCacheStorage = FetchCacheStorageSpy();
    sut = LocalLoadProducts(fetchCacheStorage: fetchCacheStorage);
    mockFetch(mockValidData());
  });

  test('Should call FetchCacheStorage', () async {
    await sut.load();

    verify(fetchCacheStorage.fetch('products')).called(1);
  });

  test('Should return a list of products on success', () async {
    final products = await sut.load();

    expect(products, [
      ProductEntity(
          id: int.parse(data[0]['id']),
          name: data[0]['name'],
          description: data[0]['description'],
          imgUrl: data[0]['img_url'],
          quantityAvailable: int.parse(data[0]['quantity_available']),
          createdAt: data[0]['created_at'],
          price: double.parse(data[0]['price']),
          supplier: LocalSupplierModel.fromJson(data[0]['supplier']).toEntity(),
          category: LocalCategoryModel.fromJson(data[0]['category']).toEntity()),
      ProductEntity(
          id: int.parse(data[1]['id']),
          name: data[1]['name'],
          description: data[1]['description'],
          imgUrl: data[1]['img_url'],
          quantityAvailable: int.parse(data[1]['quantity_available']),
          createdAt: data[1]['created_at'],
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
        "quantity_available": 'invalid price',
        'created_at': '01/08/2022 12:00:00',
        "price": 'invalid price',
        'img_url': imgUrl001,
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
        'quantity_available': '8',
        'created_at': '01/08/2022 12:00:00',
        "price": '92.28',
        'img_url': imgUrl001,
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

}
