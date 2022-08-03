import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/main/decorators/decorators.dart';
import 'package:delivery_micros_services/data/cache/cache.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}
class DeleteSecureCacheStorageSpy extends Mock implements DeleteSecureCacheStorage {}
class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  AuthorizeHttpClientDecorator sut;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  DeleteSecureCacheStorageSpy deleteSecureCacheStorage;
  HttpClientSpy httpClient;
  String url;
  Uri uri;
  String method;
  Map body;
  String token;
  String httpResponse;

  PostExpectation mockTokenCall() => when(fetchSecureCacheStorage.fetch(any));

  void mockToken() {
    token = faker.guid.guid();
    mockTokenCall().thenAnswer((_) async => token);
  }

  void mockTokenError() => mockTokenCall().thenThrow(Exception());

  PostExpectation mockHttpResponseCall() => when(httpClient.request(
    uri: anyNamed('uri'),
    method: anyNamed('method'),
    body: anyNamed('body'),
    headers: anyNamed('headers'),
  ));

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);
    mockHttpResponseCall().thenAnswer((_) async => httpResponse);
  }

  void mockHttpResponseError(HttpError error) {
    mockHttpResponseCall().thenThrow(error);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    deleteSecureCacheStorage = DeleteSecureCacheStorageSpy();
    httpClient = HttpClientSpy();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      deleteSecureCacheStorage: deleteSecureCacheStorage,
      decoratee: httpClient
    );
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);    
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mockToken();
    mockHttpResponse();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(uri: uri, method: method, body: body);

    verify(fetchSecureCacheStorage.fetch('accessToken')).called(1);
  });

  test('Should call decoratee with access accessToken on header', () async {
    await sut.request(uri: uri, method: method, body: body);
    verify(httpClient.request(uri: uri, method: method, body: body, headers: {'Authorization': token})).called(1);

    await sut.request(uri: uri, method: method, body: body, headers: {'any_header': 'any_value'});
    verify(httpClient.request(
      uri: uri,
      method: method,
      body: body,
      headers: {'Authorization': token, 'any_header': 'any_value'}
    )).called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await sut.request(uri: uri, method: method, body: body);

    expect(response, httpResponse);
  });

  test('Should throw ForbiddenError if FetchSecureCacheStorage throws', () async {
    mockTokenError();

    final future = sut.request(uri: uri, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorage.delete('accessToken')).called(1);
  });

  test('Should rethrow if decoratee throws', () async {
    mockHttpResponseError(HttpError.badRequest);

    final future = sut.request(uri: uri, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should delete cache if request throws ForbiddenError', () async {
    mockHttpResponseError(HttpError.forbidden);

    final future = sut.request(uri: uri, method: method, body: body);
    await untilCalled(deleteSecureCacheStorage.delete('accessToken'));

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorage.delete('accessToken')).called(1);
  });
}
