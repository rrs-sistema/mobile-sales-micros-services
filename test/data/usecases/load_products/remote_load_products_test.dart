import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/model/model.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

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
    'description': faker.randomGenerator.string(600),
    'quantity_available': faker.randomGenerator.integer(10, min: 5),
    'created_at': faker.date.dateTime().toIso8601String(),
    "price": faker.randomGenerator.decimal(scale: 2, min: 150),
    'img_url': faker.image.image(),
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
    'description': faker.randomGenerator.string(600),
    'quantity_available': faker.randomGenerator.integer(10, min: 5),
    'created_at': faker.date.dateTime().toIso8601String(),
    "price": faker.randomGenerator.decimal(scale: 2, min: 150),
    'img_url': faker.image.image(),
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

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
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
        description:  list[0]['description'],
        imgUrl:  list[0]['img_url'],
        quantityAvailable: list[0]['quantity_available'],
        createdAt: list[0]['created_at'],
        price: list[0]['price'],
        category: RemoteCategoryModel.fromJson(list[0]['category']).toEntity(),
        supplier: RemoteSupplierModel.fromJson(list[0]['supplier']).toEntity(),
      ),
      ProductEntity(
        id: list[1]['id'],
        name: list[1]['name'],
        description:  list[1]['description'],
        imgUrl:  list[1]['img_url'],
        quantityAvailable: list[1]['quantity_available'],
        createdAt: list[1]['created_at'],
        price: list[1]['price'],
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

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });


}
