import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/helpers/helpers.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/data/http/http.dart';

import './../../../infra/mocks/mocks.dart';
import '../../mocks/mocks.dart';

void main() {
  late RemoteLoadProducts sut;
  late HttpClientSpy httpClient;
  late String url;

  setUp(() {
    url = faker.internet.httpUrl();
    httpClient = HttpClientSpy();
    httpClient.mockRequest(ApiFactory.makeApiJson());
    sut = RemoteLoadProducts(url: url, httpClient: httpClient);
  });

  test('Should call HttpClient with correct values', () async {
    await sut.load();

    verify(() => httpClient.request(url: url, method: 'get'));
  });

  test('Should return products on 200', () async {
    final products = await sut.load();

    expect(products, ApiFactory.makeApiJsonToListProductEntity());
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
