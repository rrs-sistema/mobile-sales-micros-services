import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:delivery_micros_services/data/usecases/save_current_account/save_current_account.dart';
import 'package:delivery_micros_services/domain/entities/entities.dart';
import 'package:delivery_micros_services/domain/helpers/helpers.dart';

import './../../mocks/mocks.dart';

void main() {
  late LocalSaveCurrentAccount sut;
  late SecureCacheStorageSpy secureCacheStorage;
  late AccountEntity account;

  setUp(() {
    secureCacheStorage = SecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: secureCacheStorage);
    account = AccountEntity(accessToken: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(() => secureCacheStorage.save(key: 'accessToken', value: account.accessToken));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws', () async {
    secureCacheStorage.mockSaveError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });

}