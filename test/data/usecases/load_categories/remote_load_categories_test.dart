import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  RemoteLoadCategories sut;
  HttpClient httpClient;
  Uri uri;
  String url;
  List<Map> list;

  List<Map> mockValidData() => [
  {
    'id': 1000,
    'description': 'Bíblia'
  },
  {
    'id': 1002,
    'description': 'Tecnologia e Ciência',
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
    sut = RemoteLoadCategories(uri: uri, httpClient: httpClient);
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(httpClient.request(uri: uri, method: 'get'));
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
