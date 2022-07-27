import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/model/model.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class RemoteLoadProducts {
  final Uri uri;
  final HttpClient<List<Map>> httpClient;

  RemoteLoadProducts({@required this.uri, @required this.httpClient});

  Future<List<ProductEntity>> load() async {
    try {
      final httpResponse = await httpClient.request(uri: uri, method: 'get');
      return httpResponse.map((json) => RemoteProductModel.fromJson(json).toEntity()).toList();      
    } on HttpError {
      throw DomainError.unexpected;
    }
  }
}

class HttpClientSpy extends Mock implements HttpClient<List<Map>> {}

void main() {
  RemoteLoadProducts sut;
  HttpClient httpClient;
  Uri uri;
  String url;
  List<Map> list;

  List<Map> mockValidData() => [
  {
    'id': faker.randomGenerator.integer(25, min: 1),
    'name': faker.randomGenerator.string(50),
    'quantity_available': faker.randomGenerator.integer(10, min: 5),
    'created_at': faker.date.dateTime().toIso8601String(),
    "supplier": {
      "id": faker.randomGenerator.integer(5, min: 1),
      "name": faker.randomGenerator.string(30),
    },
    "category": {
      "id": faker.randomGenerator.integer(5, min: 1),
      "description": faker.randomGenerator.string(30),
    },
  },
  {
    'id': faker.randomGenerator.integer(25, min: 1),
    'name': faker.randomGenerator.string(50),
    'quantity_available': faker.randomGenerator.integer(10, min: 5),
    'created_at': faker.date.dateTime().toIso8601String(),
    "supplier": {
      "id": faker.randomGenerator.integer(5, min: 1),
      "name": faker.randomGenerator.string(30),
    },
    "category": {
      "id": faker.randomGenerator.integer(5, min: 1),
      "description": faker.randomGenerator.string(30),
    },
  }
];

  PostExpectation mockRequest() =>
    when(httpClient.request(uri: anyNamed('uri'), method: anyNamed('method')));

  void mockHttpData(List<Map> data) {
    list = data;
    mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    httpClient = HttpClientSpy();
    sut = RemoteLoadProducts(uri: uri, httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(uri: uri, method: 'get'));
  });

  test('Should return products on 200', () async {
    final products = await sut.load();

    expect(products, [
      ProductEntity(
        id: list[0]['id'],
        name: list[0]['name'],
        quantityAvailable: list[0]['quantity_available'],
        createdAt: DateTime.parse(list[0]['created_at']),
        category: RemoteCategoryModel.fromJson(list[0]['category']).toEntity(),
        supplier: RemoteSupplierModel.fromJson(list[0]['supplier']).toEntity(),
      ),
      ProductEntity(
        id: list[1]['id'],
        name: list[1]['name'],
        quantityAvailable: list[1]['quantity_available'],
        createdAt: DateTime.parse(list[1]['created_at']),
        category: RemoteCategoryModel.fromJson(list[1]['category']).toEntity(),
        supplier: RemoteSupplierModel.fromJson(list[1]['supplier']).toEntity(),
      )      
    ]);
  });


  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    mockHttpData([{'invalid_key': 'invalid_value'}]);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });


}
