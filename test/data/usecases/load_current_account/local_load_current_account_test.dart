import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/data/usecases/usecases.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

import './../../mocks/mocks.dart';

void main() {
  late SecureCacheStorageSpy secureCacheStorage;
  late LocalLoadCurrentAccount sut;
  late String accessToken;

  setUp(() {
    secureCacheStorage = SecureCacheStorageSpy();
    sut = LocalLoadCurrentAccount(fetchSecureCacheStorage: secureCacheStorage);
    accessToken = faker.guid.guid();
    secureCacheStorage.mockFetch(accessToken);
  });

  test('Should call FetchSecureCacheStorage with correct value', () async {
    await sut.load();

    verify(() => secureCacheStorage.fetch('accessToken'));
  });
  
  test('Should return an AccountEntity', () async {
    final account = await sut.load();

    expect(account, AccountEntity(accessToken: accessToken));
  });

  test('Should throw UnexpectedEror if FetchSecureCacheStorage throws', () async {
    secureCacheStorage.mockFetchError();

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedEror if FetchSecureCacheStorage returns null', () async {
    secureCacheStorage.mockFetch(null);

    final future = sut.load();

    expect(future, throwsA(DomainError.unexpected));
  });

}