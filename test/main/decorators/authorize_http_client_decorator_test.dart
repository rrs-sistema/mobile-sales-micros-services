import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:delivery_micros_services/data/cache/cache.dart';
import 'package:delivery_micros_services/data/http/http.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator({@required this.fetchSecureCacheStorage, @required this.decoratee});

  Future<void> request(
      {@required Uri uri,
      @required String method,
      Map body,
      Map headers}) async {
    final token = await fetchSecureCacheStorage.fetchSecure('accessToken');
    final authorizadHeaders = {'x-access-token': token};
    await decoratee.request(uri: uri, method: method, body: body, headers: authorizadHeaders);
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

  void mackToken() {
    token = faker.guid.guid();
    when(fetchSecureCacheStorage.fetchSecure(any)).thenAnswer((_) async => token);
  }

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    httpClient = HttpClientSpy();
    sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage,
      decoratee: httpClient
    );
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mackToken();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(uri: uri, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('accessToken')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(uri: uri, method: method, body: body);

    verify(httpClient.request(uri: uri, method: method, body: body, headers: {'x-access-token': token})).called(1);
  });
}
