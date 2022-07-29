import 'package:mockito/mockito.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:delivery_micros_services/data/cache/cache.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AuthorizeHttpClientDecorator({@required this.fetchSecureCacheStorage});

  Future<void> request(
      {@required Uri uri,
      @required String method,
      Map body,
      Map headers}) async {
    await fetchSecureCacheStorage.fetchSecure('accessToken');
  }
}

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

void main() {
  AuthorizeHttpClientDecorator sut;
  FetchSecureCacheStorageSpy fetchSecureCacheStorage;
  String url;
  Uri uri;
  String method;
  Map body;

  setUp(() {
    fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    sut = AuthorizeHttpClientDecorator(fetchSecureCacheStorage: fetchSecureCacheStorage);
    url = faker.internet.httpUrl();
    uri = Uri.parse(url);
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(uri: uri, method: method, body: body);

    verify(fetchSecureCacheStorage.fetchSecure('accessToken')).called(1);
  });
}
