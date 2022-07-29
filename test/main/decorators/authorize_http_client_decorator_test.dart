import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:delivery_micros_services/data/cache/cache.dart';

class AuthorizeHttpClientDecorator {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  AuthorizeHttpClientDecorator({@required this.fetchSecureCacheStorage});

  Future<void> request() async {
    await fetchSecureCacheStorage.fetchSecure('accessToken');
  }
}

class FetchSecureCacheStorageSpy extends Mock implements FetchSecureCacheStorage {}

void main() {

  test('Should call FetchSecureCacheStorage with correct key', () async {
    final fetchSecureCacheStorage = FetchSecureCacheStorageSpy();
    final sut = AuthorizeHttpClientDecorator(
      fetchSecureCacheStorage: fetchSecureCacheStorage
    );

    await sut.request();

    verify(fetchSecureCacheStorage.fetchSecure('accessToken')).called(1);
  });
}