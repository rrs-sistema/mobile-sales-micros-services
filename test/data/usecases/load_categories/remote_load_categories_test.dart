import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/http/http.dart';

import '../../../infra/mocks/mocks.dart';
import './../../mocks/mocks.dart';


void main() {
  late RemoteLoadCategories sut;
  late HttpClientSpy httpClient;
  late String url;
  late List<Map<dynamic, dynamic>> list;

  List<Map<dynamic, dynamic>> mockValidData() => [
  {
    'id': 1000,
    'description': 'Bíblia'
  },
  {
    'id': 1002,
    'description': 'Tecnologia e Ciência',
  }
];

  setUp(() {
    url = faker.internet.httpUrl();
    list = mockValidData();
    httpClient = HttpClientSpy();
    httpClient.mockRequest(list);
    sut = RemoteLoadCategories(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return categories on 200', () async {
    final categories = await sut.load();

    expect(categories, [
      CategoryEntity(
        id: list[0]['id'],
        description:  list[0]['description'],
      ),
      CategoryEntity(
        id: list[1]['id'],
        description:  list[1]['description'],
      )      
    ]);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', () async {
    httpClient.mockRequest(ApiFactory.makeInvalidJson());

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    httpClient.mockRequestError(HttpError.notFound);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    httpClient.mockRequestError(HttpError.serverError);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw AccessDeniedError if HttpClient returns 403', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = sut.load();

    expect(future, throwsA(DomainError.accessDenied));
  });

}
