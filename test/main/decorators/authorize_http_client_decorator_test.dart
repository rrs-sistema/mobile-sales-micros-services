import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:delivery_micros_services/data/cache/cache.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class AuthorizeHttpClientDecorator implements HttpClient{
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator(
      {@required this.fetchSecureCacheStorage, @required this.decoratee});

  Future<dynamic> request({@required Uri uri, @required String method, Map body, Map headers}) async {
    try {
      final token = await fetchSecureCacheStorage.fetchSecure('accessToken');
      final authorizadHeaders = headers ?? {}..addAll({'x-access-token': token});
      return await decoratee.request(uri: uri, method: method, body: body, headers: authorizadHeaders);      
    } on HttpError {
      rethrow;
    } catch (error) {
      throw HttpError.forbidden;
    }
  }
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  AuthorizeHttpClientDecorator sut;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  HttpClientSpy httpClient;
  String url;
  Uri uri;
  String method;
  Map body;
  String token;
  String httpResponse;

  PostExpectation mockTokenCall() => when(fetchSecureCacheStorage.fetchSecure(any));
  void mackToken() {
    token = faker.guid.guid();
    mockTokenCall().thenAnswer((_) async => token);
  }

  PostExpectation mockHttpResponseCall() => when(
    when(httpClient.request(
            uri: anyNamed('uri'),
            method: anyNamed('method'),
            body: anyNamed('body'),
            headers: anyNamed('headers')))
  );

  void mackTokenError() {
    mockHttpResponseCall().thenThrow(Exception());
  }

  void mackHttpResponseError(HttpError error) {
    mockHttpResponseCall().thenThrow(error);
  }

  void mackHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);
    when(httpClient.request(
            uri: anyNamed('uri'),
            method: anyNamed('method'),
            body: anyNamed('body'),
            headers: anyNamed('headers')))
        .thenAnswer((_) async => httpResponse);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    httpClient = HttpClientSpy();
    sut = AuthorizeHttpClientDecorator(
        fetchSecureCacheStorage: fetchSecureCacheStorage,
        decoratee: httpClient);
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mackToken();
    mackHttpResponse();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(uri: uri, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('accessToken')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(uri: uri, method: method, body: body);
    verify(httpClient.request(
        uri: uri,
        method: method,
        body: body,
        headers: {'x-access-token': token})).called(1);

    await sut.request(
        uri: uri,
        method: method,
        body: body,
        headers: {'any_header': 'any_value'});
    verify(httpClient.request(
            uri: uri,
            method: method,
            body: body,
            headers: {'x-access-token': token, 'any_header': 'any_value'}))
        .called(1);
  });

  test('Should return same result as decoratee', () async {
    final response = await sut.request(uri: uri, method: method, body: body);

    expect(response, httpResponse);
  });

  test('Should throw ForbiddenError if FetchSecureCacheStorage throws', () async {
    mackTokenError();

    final future = sut.request(uri: uri, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
  });

  test('Should rethrow if decoratee throws', () async {
    mackHttpResponseError(HttpError.badRequest);

    final future = sut.request(uri: uri, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });


}
