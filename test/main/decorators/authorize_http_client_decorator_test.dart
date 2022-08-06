import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/main/decorators/decorators.dart';
import 'package:delivery_micros_services/data/http/http.dart';

import './../../data/mocks/mocks.dart';

void main() {
  late AuthorizeHttpClientDecorator sut;
  late SecureCacheStorageSpy secureCacheStorage;
  late HttpClientSpy httpClient;
  late String url;
  late String method;
  late Map body;
  late String token;
  late String httpResponse;
  /*
  When mockTokenCall() => when(() => secureCacheStorage.fetch(any()));

  void mockToken() {
    
    mockTokenCall().thenAnswer((_) async => token);
  }

  void mockTokenError() => mockTokenCall().thenThrow(Exception());

  When mockHttpResponseCall() => when(() => httpClient.request(
    url: any(named:  'url'),
    method: any(named:  'method'),
    body: any(named:  'body'),
    headers: any(named:  'headers'),
  ));

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);
    mockHttpResponseCall().thenAnswer((_) async => httpResponse);
  }

  void mockHttpResponseError(HttpError error) {
    mockHttpResponseCall().thenThrow(error);
  }
  */
  setUp(() {
    token = faker.guid.guid();
    url = faker.internet.httpUrl();
    body = {'any_key': 'any_value'};
    httpResponse = faker.randomGenerator.string(50);
    method = faker.randomGenerator.string(10);

    secureCacheStorage = SecureCacheStorageSpy();
    secureCacheStorage.mockFetch(token);
    httpClient = HttpClientSpy();
    httpClient.mockRequest(httpResponse);
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: secureCacheStorage,
      deleteSecureCacheStorage: secureCacheStorage,
      decoratee: httpClient
    );
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);

    verify(() => secureCacheStorage.fetch('accessToken')).called(1);
  });

  test('Should call decoratee with access accessToken on header', () async {
    await sut.request(url: url, method: method, body: body);
    verify(() => httpClient.request(url: url, method: method, body: body, headers: {'Authorization': token})).called(1);

    await sut.request(url: url, method: method, body: body, headers: {'any_header': 'any_value'});
    verify(() => httpClient.request(
      url: url,
      method: method,
      body: body,
      headers: {'Authorization': token, 'any_header': 'any_value'}
    )).called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await sut.request(url: url, method: method, body: body, headers: {});

    expect(response, httpResponse);
  });

  test('Should throw ForbiddenError if FetchSecureCacheStorage throws', () async {
    secureCacheStorage.mockFetchError();

    final future = sut.request(url: url, method: method, body: body, headers: {});

    expect(future, throwsA(HttpError.forbidden));
    verify(() => secureCacheStorage.delete('accessToken')).called(1);
  });

  test('Should rethrow if decoratee throws', () async {
    httpClient.mockRequestError(HttpError.badRequest);

    final future = sut.request(url: url, method: method, body: body, headers: {});

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should delete cache if request throws ForbiddenError', () async {
    httpClient.mockRequestError(HttpError.forbidden);

    final future = sut.request(url: url, method: method, body: body, headers: {});
    await untilCalled(() => secureCacheStorage.delete('accessToken'));

    expect(future, throwsA(HttpError.forbidden));
    verify(() => secureCacheStorage.delete('accessToken')).called(1);
  });
}
